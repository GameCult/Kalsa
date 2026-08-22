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
    Set-Content -LiteralPath (Join-Path $content "index.md") -Encoding utf8 -Value "# Fixture`n`nSee [[Institution]]."
    Set-Content -LiteralPath (Join-Path $content "Institution.md") -Encoding utf8 -Value "# Institution`n`nA bounded test note."

    & (Join-Path $PSScriptRoot "verify-seed.ps1")
    & (Join-Path $PSScriptRoot "check-wikilinks.ps1") -ContentRoot $content
    & (Join-Path $PSScriptRoot "check-publication-boundary.ps1") -RepositoryRoot $fixtureFull -ContentRoot $content -SkipEntrypointCheck
    & (Join-Path $PSScriptRoot "measure-depth.ps1") -ContentRoot $content -CompareRoot (Join-Path $fixtureFull "missing-comparison") | Out-Null

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

    $forbidden = Join-Path $content "workshop"
    New-Item -ItemType Directory -Path $forbidden | Out-Null
    $caughtBoundary = $false
    try {
        & (Join-Path $PSScriptRoot "check-publication-boundary.ps1") -RepositoryRoot $fixtureFull -ContentRoot $content -SkipEntrypointCheck | Out-Null
    }
    catch {
        $caughtBoundary = $true
    }
    if (-not $caughtBoundary) {
        throw "Publication checker failed to reject a nested workshop directory"
    }

    Write-Output "Lore tool tests passed, including broken-link and publication-boundary negative checks."
}
finally {
    $resolvedFixture = [System.IO.Path]::GetFullPath($fixtureFull)
    if ($resolvedFixture.StartsWith($tempBase + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase) -and
        ([System.IO.Path]::GetFileName($resolvedFixture) -like 'kalsa-lore-tools-*') -and
        (Test-Path -LiteralPath $resolvedFixture)) {
        Remove-Item -LiteralPath $resolvedFixture -Recurse -Force
    }
}
