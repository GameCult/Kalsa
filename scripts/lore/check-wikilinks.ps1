param(
    [string]$ContentRoot
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $ContentRoot) {
    $ContentRoot = Join-Path $repoRoot "Kalsa"
}
$contentFull = [System.IO.Path]::GetFullPath($ContentRoot)
if (-not (Test-Path -LiteralPath $contentFull -PathType Container)) {
    throw "Canonical content root not found: $contentFull"
}

$notes = @(Get-ChildItem -LiteralPath $contentFull -Recurse -File -Filter '*.md')
$allFiles = @(Get-ChildItem -LiteralPath $contentFull -Recurse -File)
$noteByStem = @{}
$noteByRelative = @{}
$fileByName = @{}

foreach ($note in $notes) {
    $stem = [System.IO.Path]::GetFileNameWithoutExtension($note.Name).ToLowerInvariant()
    if (-not $noteByStem.ContainsKey($stem)) { $noteByStem[$stem] = @() }
    $noteByStem[$stem] += $note.FullName
    $relative = $note.FullName.Substring($contentFull.Length).TrimStart('\', '/') -replace '\\', '/'
    $noteByRelative[([System.IO.Path]::ChangeExtension($relative, $null).TrimEnd('.').ToLowerInvariant())] = $note.FullName
}
foreach ($file in $allFiles) {
    $key = $file.Name.ToLowerInvariant()
    if (-not $fileByName.ContainsKey($key)) { $fileByName[$key] = @() }
    $fileByName[$key] += $file.FullName
}

$errors = @()
$linkCount = 0
foreach ($note in $notes) {
    $text = Get-Content -Raw -LiteralPath $note.FullName -Encoding utf8
    foreach ($match in [regex]::Matches($text, '!??\[\[(?<target>[^\]]+)\]\]')) {
        $linkCount += 1
        $target = ($match.Groups['target'].Value -split '\|', 2)[0]
        $target = ($target -split '#', 2)[0].Trim()
        if (-not $target) { continue }
        $target = $target -replace '\\', '/'
        $resolved = @()
        $extension = [System.IO.Path]::GetExtension($target)
        if ($extension -and $extension.ToLowerInvariant() -ne '.md') {
            $relativeAsset = [System.IO.Path]::GetFullPath((Join-Path $note.DirectoryName $target))
            $rootAsset = [System.IO.Path]::GetFullPath((Join-Path $contentFull $target))
            if (Test-Path -LiteralPath $relativeAsset -PathType Leaf) { $resolved += $relativeAsset }
            if (Test-Path -LiteralPath $rootAsset -PathType Leaf) { $resolved += $rootAsset }
            $assetName = [System.IO.Path]::GetFileName($target).ToLowerInvariant()
            if ($fileByName.ContainsKey($assetName)) { $resolved += $fileByName[$assetName] }
        }
        else {
            $noteTarget = if ($extension) { [System.IO.Path]::ChangeExtension($target, $null).TrimEnd('.') } else { $target }
            $relativeKey = $noteTarget.TrimStart('/')
            if ($noteByRelative.ContainsKey($relativeKey.ToLowerInvariant())) {
                $resolved += $noteByRelative[$relativeKey.ToLowerInvariant()]
            }
            $relativeCandidate = [System.IO.Path]::GetFullPath((Join-Path $note.DirectoryName ($noteTarget + '.md')))
            if (Test-Path -LiteralPath $relativeCandidate -PathType Leaf) { $resolved += $relativeCandidate }
            $stem = [System.IO.Path]::GetFileName($noteTarget).ToLowerInvariant()
            if ($noteByStem.ContainsKey($stem)) { $resolved += $noteByStem[$stem] }
        }
        $resolved = @($resolved | Sort-Object -Unique)
        $sourceRelative = $note.FullName.Substring($contentFull.Length).TrimStart('\', '/')
        if ($resolved.Count -eq 0) {
            $errors += "$sourceRelative -> [[$($match.Groups['target'].Value)]] is unresolved"
        }
        elseif ($resolved.Count -gt 1 -and $target -notmatch '[/\\]') {
            $errors += "$sourceRelative -> [[$($match.Groups['target'].Value)]] is ambiguous across $($resolved.Count) files"
        }
    }
}

if ($errors.Count -gt 0) {
    throw "Wikilink verification failed:`n- $($errors -join "`n- ")"
}

Write-Output "Wikilink verification passed: $linkCount links across $($notes.Count) canonical notes."
