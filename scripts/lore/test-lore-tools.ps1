$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$tempBase = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\', '/')
$fixture = Join-Path $tempBase ("kalsa-lore-tools-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $fixture | Out-Null
$fixtureFull = [System.IO.Path]::GetFullPath($fixture)
if (-not $fixtureFull.StartsWith($tempBase + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to create test fixture outside the system temporary directory"
}

try {
    $content = Join-Path $fixtureFull "Kalsa"
    New-Item -ItemType Directory -Path $content | Out-Null
    Set-Content -LiteralPath (Join-Path $content "index.md") -Encoding utf8 -Value "# Fixture`n`nSee [[Institution#Bounded authority]]."
    Set-Content -LiteralPath (Join-Path $content "Institution.md") -Encoding utf8 -Value "# Institution`n`n## Bounded authority`n`nA bounded test note."

    & (Join-Path $PSScriptRoot "verify-seed.ps1")
    & (Join-Path $PSScriptRoot "check-wikilinks.ps1") -ContentRoot $content
    & (Join-Path $PSScriptRoot "check-publication-boundary.ps1") -RepositoryRoot $fixtureFull -ContentRoot $content -SkipEntrypointCheck
    & (Join-Path $PSScriptRoot "measure-depth.ps1") -ContentRoot $content -CompareRoot (Join-Path $fixtureFull "missing-comparison") | Out-Null

    $output = Join-Path $fixtureFull "quartz-site\public"
    $static = Join-Path $output "static"
    New-Item -ItemType Directory -Path $static -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $output "404.html") -Encoding utf8 -Value "<!doctype html><title>Not found</title>"
    Set-Content -LiteralPath (Join-Path $output "index.html") -Encoding utf8 -Value "<!doctype html><title>Fixture</title>"
    Set-Content -LiteralPath (Join-Path $output "Institution.html") -Encoding utf8 -Value "<!doctype html><title>Institution</title>"
    Set-Content -LiteralPath (Join-Path $static "contentIndex.json") -Encoding utf8 -Value '{"index":{},"Institution":{}}'
    Set-Content -LiteralPath (Join-Path $output "sitemap.xml") -Encoding utf8 -Value '<urlset><url><loc>https://example.invalid/</loc></url><url><loc>https://example.invalid/Institution</loc></url></urlset>'
    Set-Content -LiteralPath (Join-Path $output "index.xml") -Encoding utf8 -Value '<rss><channel><item><link>https://example.invalid/</link></item><item><link>https://example.invalid/Institution</link></item></channel></rss>'
    & (Join-Path $PSScriptRoot "check-publication-output.ps1") -RepositoryRoot $fixtureFull -ContentRoot $content -OutputRoot $output

    $staleOutput = Join-Path $output "Stale.html"
    Set-Content -LiteralPath $staleOutput -Encoding utf8 -Value "<!doctype html><title>Stale</title>"
    $caughtStaleOutput = $false
    try {
        & (Join-Path $PSScriptRoot "check-publication-output.ps1") -RepositoryRoot $fixtureFull -ContentRoot $content -OutputRoot $output | Out-Null
    }
    catch {
        $caughtStaleOutput = $true
    }
    if (-not $caughtStaleOutput) {
        throw "Publication-output checker failed to reject stale generated HTML"
    }
    Remove-Item -LiteralPath $staleOutput -Force

    $vault = Join-Path $fixtureFull "KalsaVault"
    $vaultPublic = Join-Path $vault "Public"
    $vaultSpoilers = Join-Path $vault "Spoilers"
    New-Item -ItemType Directory -Path $vaultPublic, $vaultSpoilers -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $vault "index.md") -Encoding utf8 -Value "# Vault`n`n[[Public/index|Readers]]`n`n[[Spoilers/index|Spoilers]]"
    Set-Content -LiteralPath (Join-Path $vaultPublic "index.md") -Encoding utf8 -Value "# Readers"
    Set-Content -LiteralPath (Join-Path $vaultSpoilers "index.md") -Encoding utf8 -Value "# Spoilers"
    & (Join-Path $PSScriptRoot "check-vault-layout.ps1") -VaultRoot $vault

    $exposed = Join-Path $vault "Foundations"
    New-Item -ItemType Directory -Path $exposed | Out-Null
    Set-Content -LiteralPath (Join-Path $exposed "Hidden.md") -Encoding utf8 -Value "# Hidden"
    $caughtExposedDirectory = $false
    try {
        & (Join-Path $PSScriptRoot "check-vault-layout.ps1") -VaultRoot $vault | Out-Null
    }
    catch {
        $caughtExposedDirectory = $true
    }
    if (-not $caughtExposedDirectory) {
        throw "Vault-layout checker failed to reject an exposed author directory"
    }
    Remove-Item -LiteralPath $exposed -Recurse -Force

    $vaultObsidian = Join-Path $vault ".obsidian"
    New-Item -ItemType Directory -Path $vaultObsidian | Out-Null
    Set-Content -LiteralPath (Join-Path $vaultObsidian "workspace.json") -Encoding utf8 -Value '{"main":{"file":"Spoilers/Foundations/Hidden.md"}}'
    $caughtSpoilerSession = $false
    try {
        & (Join-Path $PSScriptRoot "check-vault-layout.ps1") -VaultRoot $vault | Out-Null
    }
    catch {
        $caughtSpoilerSession = $true
    }
    if (-not $caughtSpoilerSession) {
        throw "Vault-layout checker failed to reject spoiler-bound Obsidian session state"
    }

    $broken = Join-Path $content "Broken.md"
    Set-Content -LiteralPath $broken -Encoding utf8 -Value "# Broken`n`nSee [[No Such Note]]."
    $caughtBrokenLink = $false
    try {
        & (Join-Path $PSScriptRoot "check-wikilinks.ps1") -ContentRoot $content | Out-Null
    }
    catch {
        $caughtBrokenLink = $true
    }
    if (-not $caughtBrokenLink) {
        throw "Wikilink checker failed to reject an unresolved link"
    }
    Remove-Item -LiteralPath $broken -Force

    $brokenAnchor = Join-Path $content "Broken Anchor.md"
    Set-Content -LiteralPath $brokenAnchor -Encoding utf8 -Value "# Broken Anchor`n`nSee [[Institution#No such heading]]."
    $caughtBrokenAnchor = $false
    try {
        & (Join-Path $PSScriptRoot "check-wikilinks.ps1") -ContentRoot $content | Out-Null
    }
    catch {
        $caughtBrokenAnchor = $true
    }
    if (-not $caughtBrokenAnchor) {
        throw "Wikilink checker failed to reject a missing heading anchor"
    }
    Remove-Item -LiteralPath $brokenAnchor -Force

    $outside = Join-Path $fixtureFull "Outside.md"
    Set-Content -LiteralPath $outside -Encoding utf8 -Value "# Outside`n`nThis note is outside the selected publication root."
    $brokenEscape = Join-Path $content "Broken Escape.md"
    Set-Content -LiteralPath $brokenEscape -Encoding utf8 -Value "# Broken Escape`n`nSee [[../Outside]]."
    $caughtEscapedLink = $false
    try {
        & (Join-Path $PSScriptRoot "check-wikilinks.ps1") -ContentRoot $content | Out-Null
    }
    catch {
        $caughtEscapedLink = $true
    }
    if (-not $caughtEscapedLink) {
        throw "Wikilink checker failed to reject a link outside the selected content root"
    }
    Remove-Item -LiteralPath $brokenEscape -Force

    $forbidden = Join-Path $content "Spoilers"
    New-Item -ItemType Directory -Path $forbidden | Out-Null
    $caughtBoundary = $false
    try {
        & (Join-Path $PSScriptRoot "check-publication-boundary.ps1") -RepositoryRoot $fixtureFull -ContentRoot $content -SkipEntrypointCheck | Out-Null
    }
    catch {
        $caughtBoundary = $true
    }
    if (-not $caughtBoundary) {
        throw "Publication checker failed to reject a nested spoiler directory"
    }

    & (Join-Path $PSScriptRoot "test-phase-boundary-intake.ps1")

    Write-Output "Lore tool tests passed, including phase-boundary intake, broken-link, broken-anchor, escaped-link, stale-output, exposed-vault-directory, spoiler-session, and publication-boundary negative checks."
}
finally {
    $resolvedFixture = [System.IO.Path]::GetFullPath($fixtureFull)
    if ($resolvedFixture.StartsWith($tempBase + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase) -and
        ([System.IO.Path]::GetFileName($resolvedFixture) -like 'kalsa-lore-tools-*') -and
        (Test-Path -LiteralPath $resolvedFixture)) {
        Remove-Item -LiteralPath $resolvedFixture -Recurse -Force
    }
}
