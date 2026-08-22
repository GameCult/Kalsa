param(
    [string]$MemorySource,
    [string]$StatePath,
    [string]$EpiphanyRoot
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
if (-not $MemorySource) {
    $MemorySource = Join-Path $PSScriptRoot "project-memory.md"
}
if (-not $StatePath) {
    $StatePath = Join-Path $PSScriptRoot "state\project-memory.cc"
}
if (-not $EpiphanyRoot) {
    $EpiphanyRoot = Join-Path (Split-Path -Parent $repoRoot) "Epiphany"
}

$sourceFull = [System.IO.Path]::GetFullPath($MemorySource)
$stateFull = [System.IO.Path]::GetFullPath($StatePath)
$epiphanyFull = [System.IO.Path]::GetFullPath($EpiphanyRoot)
$stateHome = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "state"))

if (-not (Test-Path -LiteralPath $sourceFull -PathType Leaf)) {
    throw "Project memory source not found: $sourceFull"
}
if (-not $stateFull.StartsWith($stateHome + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "State path must remain inside $stateHome"
}

$storeTool = Join-Path $epiphanyFull "target\debug\epiphany-state-ledger-store.exe"
if (-not (Test-Path -LiteralPath $storeTool -PathType Leaf)) {
    throw "Epiphany state-ledger tool not found: $storeTool"
}

$text = Get-Content -Raw -LiteralPath $sourceFull -Encoding utf8
$timestampMatch = [regex]::Match($text, '(?m)^snapshot_at:\s*(?<timestamp>\S+)\s*$')
if (-not $timestampMatch.Success) {
    throw "project-memory.md must contain a snapshot_at timestamp"
}
$timestamp = $timestampMatch.Groups['timestamp'].Value

$section = $null
$records = @()
foreach ($line in ($text -split "`r?`n")) {
    if ($line -eq "## Durable judgments") {
        $section = "judgment"
        continue
    }
    if ($line -eq "## Open questions") {
        $section = "question"
        continue
    }
    if ($line -match '^## ') {
        $section = $null
        continue
    }
    $entry = [regex]::Match($line, '^- `(?<id>[^`]+)` — (?<summary>.+)$')
    if ($entry.Success -and $section) {
        $records += [pscustomobject]@{
            Id = $entry.Groups['id'].Value
            Kind = $section
            Summary = $entry.Groups['summary'].Value
        }
    }
}

if ($records.Count -eq 0) {
    throw "No parseable project-memory entries found"
}
if (($records.Id | Sort-Object -Unique).Count -ne $records.Count) {
    throw "Project-memory identifiers must be unique"
}

$stateDir = Split-Path -Parent $stateFull
New-Item -ItemType Directory -Force -Path $stateDir | Out-Null
$stageName = ([System.IO.Path]::GetFileNameWithoutExtension($stateFull) + "." + [guid]::NewGuid().ToString() + ".cc")
$stagePath = Join-Path $stateDir $stageName

try {
    foreach ($record in $records) {
        $type = if ($record.Kind -eq "judgment") { "project-memory-judgment" } else { "project-memory-question" }
        $status = if ($record.Kind -eq "judgment") { "active" } else { "open" }
        $note = $record.Id + ": " + $record.Summary
        & $storeTool add-evidence --store $stagePath --ts $timestamp --type $type --status $status --note $note --branch "kalsa-project-memory" | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "State-ledger write failed for $($record.Id)"
        }
    }

    & $storeTool status --store $stagePath | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Generated project-memory state failed inspection"
    }

    Move-Item -LiteralPath $stagePath -Destination $stateFull -Force
    $stageLock = $stagePath + ".lock"
    if (Test-Path -LiteralPath $stageLock) {
        Remove-Item -LiteralPath $stageLock -Force
    }
}
finally {
    if (Test-Path -LiteralPath $stagePath) {
        Remove-Item -LiteralPath $stagePath -Force
    }
}

Write-Output "Projected $($records.Count) memory records to $stateFull"
