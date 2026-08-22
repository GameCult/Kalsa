param(
    [string]$ManifestPath,
    [string]$SeedRoot
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $ManifestPath) {
    $ManifestPath = Join-Path $repoRoot "seed\manifest.md"
}
if (-not $SeedRoot) {
    $SeedRoot = Join-Path $repoRoot "seed\original"
}

$manifestFull = [System.IO.Path]::GetFullPath($ManifestPath)
$seedFull = [System.IO.Path]::GetFullPath($SeedRoot)
if (-not (Test-Path -LiteralPath $manifestFull -PathType Leaf)) {
    throw "Seed manifest not found: $manifestFull"
}
if (-not (Test-Path -LiteralPath $seedFull -PathType Container)) {
    throw "Seed directory not found: $seedFull"
}

$manifest = Get-Content -LiteralPath $manifestFull -Encoding utf8
$entries = @()
foreach ($line in $manifest) {
    $match = [regex]::Match($line, '^\|\s*`(?<file>[^`]+)`\s*\|\s*(?<bytes>[\d,]+)\s*\|\s*`(?<hash>[0-9a-fA-F]{64})`\s*\|')
    if ($match.Success) {
        $entries += [pscustomobject]@{
            File = $match.Groups['file'].Value
            Bytes = [int64]($match.Groups['bytes'].Value -replace ',', '')
            Hash = $match.Groups['hash'].Value.ToLowerInvariant()
        }
    }
}

if ($entries.Count -eq 0) {
    throw "No seed entries were parsed from $manifestFull"
}
if (($entries.File | Sort-Object -Unique).Count -ne $entries.Count) {
    throw "Seed manifest contains duplicate filenames"
}

$errors = @()
foreach ($entry in $entries) {
    $path = Join-Path $seedFull $entry.File
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors += "missing: $($entry.File)"
        continue
    }
    $item = Get-Item -LiteralPath $path
    if ($item.Length -ne $entry.Bytes) {
        $errors += "size mismatch: $($entry.File) expected $($entry.Bytes), found $($item.Length)"
    }
    $actualHash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualHash -ne $entry.Hash) {
        $errors += "hash mismatch: $($entry.File) expected $($entry.Hash), found $actualHash"
    }
}

$expected = @($entries.File | Sort-Object)
$actual = @(Get-ChildItem -LiteralPath $seedFull -File | Select-Object -ExpandProperty Name | Sort-Object)
$unexpected = @($actual | Where-Object { $_ -notin $expected })
if ($unexpected.Count -gt 0) {
    $errors += "unmanifested seed files: $($unexpected -join ', ')"
}

if ($errors.Count -gt 0) {
    throw "Seed verification failed:`n- $($errors -join "`n- ")"
}

Write-Output "Seed verification passed: $($entries.Count) immutable witnesses match size and SHA-256."
