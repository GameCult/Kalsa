param(
    [string]$RepositoryRoot,
    [string]$ContentRoot,
    [switch]$SkipEntrypointCheck
)

$ErrorActionPreference = "Stop"

if (-not $RepositoryRoot) {
    $RepositoryRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
}
$repoFull = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/')
if (-not $ContentRoot) {
    $ContentRoot = Join-Path $repoFull "Kalsa\Public"
}
$contentFull = [System.IO.Path]::GetFullPath($ContentRoot).TrimEnd('\', '/')

if (-not (Test-Path -LiteralPath $repoFull -PathType Container)) {
    throw "Repository root not found: $repoFull"
}
if (-not (Test-Path -LiteralPath $contentFull -PathType Container)) {
    throw "Reader publication root not found: $contentFull"
}
if (-not $contentFull.StartsWith($repoFull + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Publication root must remain inside the repository root"
}

$errors = @()
$reserved = @('seed', 'workshop', 'spoilers', '.epiphany', '.voidbot', 'site', '.github', 'scripts', 'quartz-site', '.quartz-build')
foreach ($directory in Get-ChildItem -LiteralPath $contentFull -Recurse -Directory -Force) {
    if ($directory.Name.ToLowerInvariant() -in $reserved) {
        $errors += "reserved project directory nested in publication root: $($directory.FullName)"
    }
}

foreach ($item in Get-ChildItem -LiteralPath $contentFull -Recurse -Force) {
    if (($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
        $errors += "reparse point may escape publication ownership: $($item.FullName)"
    }
}

if (-not $SkipEntrypointCheck) {
    $launcher = Join-Path $repoFull "scripts\quartz\quartz.ps1"
    $workflow = Join-Path $repoFull ".github\workflows\deploy-quartz.yml"
    if (-not (Test-Path -LiteralPath $launcher -PathType Leaf)) {
        $errors += "Quartz launcher missing: $launcher"
    }
    else {
        $launcherText = Get-Content -Raw -LiteralPath $launcher -Encoding utf8
        if ($launcherText -notmatch '(?s)--contentDir.{0,80}["'']Kalsa/Public["'']') {
            $errors += "Quartz launcher does not bind --contentDir to Kalsa/Public"
        }
    }
    if (-not (Test-Path -LiteralPath $workflow -PathType Leaf)) {
        $errors += "Quartz deployment workflow missing: $workflow"
    }
    else {
        $workflowText = Get-Content -Raw -LiteralPath $workflow -Encoding utf8
        if ($workflowText -notmatch '(?m)^\s*content-dir:\s*Kalsa/Public\s*$') {
            $errors += "Quartz deployment workflow does not bind content-dir to Kalsa/Public"
        }
    }
}

if ($errors.Count -gt 0) {
    throw "Publication-boundary verification failed:`n- $($errors -join "`n- ")"
}

Write-Output "Publication boundary passed: only $contentFull is admitted as reader-site input."
