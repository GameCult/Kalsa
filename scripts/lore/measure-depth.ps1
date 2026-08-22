param(
    [string]$ContentRoot,
    [string]$CompareRoot = "F:\Projects\AetheriaLore\Aetheria\Worldbuilding"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $ContentRoot) {
    $ContentRoot = Join-Path $repoRoot "Kalsa"
}

function Measure-Branch {
    param(
        [string]$Root,
        [string]$Label
    )

    $full = [System.IO.Path]::GetFullPath($Root)
    if (-not (Test-Path -LiteralPath $full -PathType Container)) {
        throw "Depth input root not found: $full"
    }
    $rows = @()
    foreach ($file in Get-ChildItem -LiteralPath $full -Recurse -File -Filter '*.md') {
        $text = Get-Content -Raw -LiteralPath $file.FullName -Encoding utf8
        $relative = $file.FullName.Substring($full.Length).TrimStart('\', '/')
        $rows += [pscustomobject]@{
            Path = $relative
            IsIndex = $file.Name -ieq 'index.md'
            Words = ([regex]::Matches($text, "\b[\p{L}\p{N}'-]+\b")).Count
            Wikilinks = ([regex]::Matches($text, '\[\[')).Count
            Headings = ([regex]::Matches($text, '(?m)^#{1,6}\s')).Count
        }
    }

    $nonIndex = @($rows | Where-Object { -not $_.IsIndex })
    $wordValues = @($nonIndex.Words | Sort-Object)
    $median = if ($wordValues.Count -eq 0) { 0 } else { $wordValues[[math]::Floor($wordValues.Count / 2)] }
    $summary = [pscustomobject]@{
        Branch = $Label
        Notes = $rows.Count
        NonIndexNotes = $nonIndex.Count
        Words = ($rows | Measure-Object Words -Sum).Sum
        Wikilinks = ($rows | Measure-Object Wikilinks -Sum).Sum
        Headings = ($rows | Measure-Object Headings -Sum).Sum
        MedianNonIndexWords = $median
        NotesWithoutWikilinks = @($nonIndex | Where-Object { $_.Wikilinks -eq 0 }).Count
    }
    return [pscustomobject]@{ Summary = $summary; Rows = $rows }
}

$kalsa = Measure-Branch -Root $ContentRoot -Label "Kalsa canonical"
$summaries = @($kalsa.Summary)
if (Test-Path -LiteralPath $CompareRoot -PathType Container) {
    $comparison = Measure-Branch -Root $CompareRoot -Label "Aetheria worldbuilding"
    $summaries += $comparison.Summary
}
else {
    Write-Warning "Comparison root not available: $CompareRoot"
}

Write-Output "Structural diagnostics (counts are pressure signals, not a depth verdict):"
$summaries | Format-Table -AutoSize

Write-Output "Kalsa notes with the least connective structure:"
$kalsa.Rows |
    Where-Object { -not $_.IsIndex } |
    Sort-Object @{ Expression = 'Wikilinks'; Ascending = $true }, @{ Expression = 'Words'; Ascending = $true } |
    Select-Object -First 20 Path, Words, Wikilinks, Headings |
    Format-Table -AutoSize

Write-Output "Qualitative parity still requires the review in workshop/deepening/benchmark.md."
