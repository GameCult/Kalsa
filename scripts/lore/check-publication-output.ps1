param(
    [string]$RepositoryRoot,
    [string]$ContentRoot,
    [string]$OutputRoot
)

$ErrorActionPreference = "Stop"

if (-not $RepositoryRoot) {
    $RepositoryRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
}
$repoFull = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/')
if (-not $ContentRoot) {
    $ContentRoot = Join-Path $repoFull "Kalsa\Public"
}
if (-not $OutputRoot) {
    $OutputRoot = Join-Path $repoFull "quartz-site\public"
}
$contentFull = [System.IO.Path]::GetFullPath($ContentRoot).TrimEnd('\', '/')
$outputFull = [System.IO.Path]::GetFullPath($OutputRoot).TrimEnd('\', '/')

foreach ($root in @($contentFull, $outputFull)) {
    if (-not (Test-Path -LiteralPath $root -PathType Container)) {
        throw "Required publication surface not found: $root"
    }
    if (-not $root.StartsWith($repoFull + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Publication surfaces must remain inside the repository root"
    }
}

function Get-SourceSlug([string]$path) {
    $relative = $path.Substring($contentFull.Length).TrimStart('\', '/') -replace '\\', '/'
    $withoutExtension = [System.IO.Path]::ChangeExtension($relative, $null).TrimEnd('.')
    return $withoutExtension -replace ' ', '-'
}

function Get-Route([string]$sourceSlug) {
    if ($sourceSlug -eq 'index') { return '' }
    if ($sourceSlug.EndsWith('/index')) { return $sourceSlug.Substring(0, $sourceSlug.Length - 6) }
    return $sourceSlug
}

function Compare-ExactSet([string]$label, [string[]]$expected, [string[]]$actual) {
    $expectedSet = @($expected | Sort-Object -Unique)
    $actualSet = @($actual | Sort-Object -Unique)
    $missing = @($expectedSet | Where-Object { $_ -notin $actualSet })
    $extra = @($actualSet | Where-Object { $_ -notin $expectedSet })
    if ($missing.Count -gt 0 -or $extra.Count -gt 0) {
        $parts = @()
        if ($missing.Count -gt 0) { $parts += "missing: $($missing -join ', ')" }
        if ($extra.Count -gt 0) { $parts += "unexpected: $($extra -join ', ')" }
        throw "$label does not match the reader source ($($parts -join '; '))"
    }
}

$sourceSlugs = @(Get-ChildItem -LiteralPath $contentFull -Recurse -File -Filter '*.md' | ForEach-Object {
    Get-SourceSlug $_.FullName
})
$routes = @($sourceSlugs | ForEach-Object { Get-Route $_ })

$contentIndexPath = Join-Path $outputFull 'static\contentIndex.json'
$sitemapPath = Join-Path $outputFull 'sitemap.xml'
$rssPath = Join-Path $outputFull 'index.xml'
foreach ($path in @($contentIndexPath, $sitemapPath, $rssPath)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Generated publication artifact missing: $path"
    }
}

$contentIndex = Get-Content -Raw -LiteralPath $contentIndexPath -Encoding utf8 | ConvertFrom-Json -AsHashtable
Compare-ExactSet 'Search index routes' $sourceSlugs @($contentIndex.Keys)

$sitemapText = Get-Content -Raw -LiteralPath $sitemapPath -Encoding utf8
$sitemapRoutes = @([regex]::Matches($sitemapText, '<loc>(?<url>[^<]+)</loc>') | ForEach-Object {
    [uri]::UnescapeDataString(([uri]$_.Groups['url'].Value).AbsolutePath.Trim('/'))
})
Compare-ExactSet 'Sitemap routes' $routes $sitemapRoutes

$rssText = Get-Content -Raw -LiteralPath $rssPath -Encoding utf8
$rssRoutes = @([regex]::Matches($rssText, '(?s)<item>.*?<link>(?<url>[^<]+)</link>.*?</item>') | ForEach-Object {
    [uri]::UnescapeDataString(([uri]$_.Groups['url'].Value).AbsolutePath.Trim('/'))
})
Compare-ExactSet 'RSS routes' $routes $rssRoutes

$expectedHtml = @('404.html')
foreach ($route in $routes) {
    $expectedHtml += if ($route) { "$route.html" } else { 'index.html' }
    if ($route -and $route.Contains('/')) {
        $segments = $route -split '/'
        for ($i = 1; $i -lt $segments.Count; $i += 1) {
            $expectedHtml += (($segments[0..($i - 1)] -join '/') + '/index.html')
        }
    }
}
$actualHtml = @(Get-ChildItem -LiteralPath $outputFull -Recurse -File -Filter '*.html' | ForEach-Object {
    $_.FullName.Substring($outputFull.Length).TrimStart('\', '/') -replace '\\', '/'
})
Compare-ExactSet 'Generated HTML routes' $expectedHtml $actualHtml

Write-Output "Publication output passed: $($sourceSlugs.Count) reader notes own search, sitemap, RSS, and HTML routes."
