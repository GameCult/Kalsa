param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('review', 'closure')]
    [string]$Boundary,

    [Parameter(Mandatory = $true)]
    [string]$PacketPath,

    [Parameter(Mandatory = $true)]
    [string]$PassPath,

    [string]$RepositoryRoot
)

$ErrorActionPreference = 'Stop'

if (-not $RepositoryRoot) {
    $RepositoryRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
}
$repoFull = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\', '/')
if (-not (Test-Path -LiteralPath $repoFull -PathType Container)) {
    throw "Repository root not found: $repoFull"
}

function Resolve-RepositoryFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Label
    )

    $candidate = $Path
    if (-not [System.IO.Path]::IsPathRooted($candidate)) {
        $candidate = Join-Path $repoFull $candidate
    }
    $full = [System.IO.Path]::GetFullPath($candidate)
    if (-not $full.StartsWith($repoFull + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "$Label must remain inside the repository root: $full"
    }
    if (-not (Test-Path -LiteralPath $full -PathType Leaf)) {
        throw "$Label not found: $full"
    }
    return $full
}

function Invoke-RepositoryGit {
    param([Parameter(Mandatory = $true)][string[]]$Arguments)

    $output = & git -C $repoFull -c core.quotepath=false @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed:`n$($output -join "`n")"
    }
    return @($output)
}

function Normalize-RepositoryPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $normalized = $Path.Trim().Trim('`').Replace('\', '/')
    while ($normalized.StartsWith('./', [System.StringComparison]::Ordinal)) {
        $normalized = $normalized.Substring(2)
    }
    return $normalized
}

function Get-FrontMatter {
    param([Parameter(Mandatory = $true)][string]$Text)

    $match = [regex]::Match($Text, '\A---\r?\n(?<body>.*?)\r?\n---(?:\r?\n|\z)', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $match.Success) {
        return ''
    }
    return $match.Groups['body'].Value
}

function Test-IsIntakeNote {
    param([Parameter(Mandatory = $true)][string]$RepositoryPath)

    $full = Join-Path $repoFull ($RepositoryPath.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
    if (-not (Test-Path -LiteralPath $full -PathType Leaf)) {
        return $false
    }

    $stem = [System.IO.Path]::GetFileNameWithoutExtension($full)
    if ($stem -match '(?i)(?:^|[-_ ])(?:proposal|handoff)(?:$|[-_ ])') {
        return $true
    }

    $frontMatter = Get-FrontMatter -Text (Get-Content -LiteralPath $full -Raw -Encoding utf8)
    if (-not $frontMatter) {
        return $false
    }

    return (
        $frontMatter -match '(?im)^\s*status:\s*(?:proposal|handoff|adopted-candidate)\s*(?:#.*)?$' -or
        $frontMatter -match '(?im)^\s*(?:type|owns):[^\r\n]*(?:proposal|handoff)' -or
        $frontMatter -match '(?im)^\s*-\s*(?:proposal|handoff)\s*$'
    )
}

$packetFull = Resolve-RepositoryFile -Path $PacketPath -Label 'Packet'
$passFull = Resolve-RepositoryFile -Path $PassPath -Label 'Pass record'
$packetText = Get-Content -LiteralPath $packetFull -Raw -Encoding utf8
$passText = Get-Content -LiteralPath $passFull -Raw -Encoding utf8

$baseMatch = [regex]::Match($passText, '(?im)^intake_base_commit:\s*([0-9a-f]{40})\s*$')
if (-not $baseMatch.Success) {
    throw 'Pass record must name a full 40-character intake_base_commit in its frontmatter'
}
$baseCommit = $baseMatch.Groups[1].Value.ToLowerInvariant()
Invoke-RepositoryGit -Arguments @('rev-parse', '--verify', "$baseCommit^{commit}") | Out-Null

$manifest = [System.Collections.Generic.Dictionary[string, string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$manifestMatches = [regex]::Matches($packetText, '(?m)^(?<hash>[0-9a-fA-F]{40})[ \t]{2,}(?<path>.+?\.md)[ \t]*\r?$')
foreach ($match in $manifestMatches) {
    $path = Normalize-RepositoryPath -Path $match.Groups['path'].Value
    $hash = $match.Groups['hash'].Value.ToLowerInvariant()
    if ($manifest.ContainsKey($path) -and $manifest[$path] -ne $hash) {
        throw "Packet contains conflicting hashes for $path"
    }
    $manifest[$path] = $hash
}
if ($manifest.Count -eq 0) {
    throw 'Packet must contain an exact raw SHA-1 Markdown manifest using: <40-hex-hash><two spaces><repository-relative-path>'
}

$dispositions = [System.Collections.Generic.Dictionary[string, object]]::new([System.StringComparer]::OrdinalIgnoreCase)
$intakeSection = [regex]::Match($passText, '(?ms)^## Phase-boundary intake\s*\r?\n(?<body>.*?)(?=^##\s|\z)')
if ($intakeSection.Success) {
    foreach ($line in ($intakeSection.Groups['body'].Value -split '\r?\n')) {
        if (-not $line.Trim().StartsWith('|')) {
            continue
        }
        $cells = $line.Split('|')
        if ($cells.Count -lt 5) {
            continue
        }
        $pathCell = $cells[1].Trim().Trim('`')
        $disposition = $cells[2].Trim().ToLowerInvariant()
        $reason = $cells[3].Trim()
        if (-not $pathCell.EndsWith('.md', [System.StringComparison]::OrdinalIgnoreCase)) {
            continue
        }
        $path = Normalize-RepositoryPath -Path $pathCell
        $dispositions[$path] = [pscustomobject]@{
            Disposition = $disposition
            Reason = $reason
        }
    }
}

$changedPaths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$gitQueries = @(
    @('diff', '--name-only', '--diff-filter=ACMR', "$baseCommit..HEAD"),
    @('diff', '--cached', '--name-only', '--diff-filter=ACMR'),
    @('diff', '--name-only', '--diff-filter=ACMR'),
    @('ls-files', '--others', '--exclude-standard')
)
foreach ($query in $gitQueries) {
    foreach ($line in (Invoke-RepositoryGit -Arguments $query)) {
        $path = Normalize-RepositoryPath -Path ([string]$line)
        if ($path.EndsWith('.md', [System.StringComparison]::OrdinalIgnoreCase)) {
            [void]$changedPaths.Add($path)
        }
    }
}

$intakeNotes = @($changedPaths | Where-Object { Test-IsIntakeNote -RepositoryPath $_ } | Sort-Object)
$errors = @()
$results = @()

foreach ($path in $intakeNotes) {
    if ($manifest.ContainsKey($path)) {
        $full = Join-Path $repoFull ($path.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
        $actualHash = (Get-FileHash -LiteralPath $full -Algorithm SHA1).Hash.ToLowerInvariant()
        if ($actualHash -ne $manifest[$path]) {
            $errors += "$path is named in the packet but its current raw SHA-1 differs from the frozen manifest"
        }
        else {
            $results += "packet: $path"
        }
        continue
    }

    if (-not $dispositions.ContainsKey($path)) {
        $errors += "$path is a changed proposal or handoff note outside the frozen packet and has no intake disposition"
        continue
    }

    $entry = $dispositions[$path]
    if ($entry.Disposition -notin @('defer', 'reject')) {
        $errors += "$path uses unsupported disposition '$($entry.Disposition)'; use defer or reject for a note outside the packet"
        continue
    }
    if ([string]::IsNullOrWhiteSpace($entry.Reason) -or $entry.Reason -match '^(?:replace-me|tbd|todo|-)$') {
        $errors += "$path requires a concrete reason or destination for disposition '$($entry.Disposition)'"
        continue
    }
    $results += "$($entry.Disposition): $path — $($entry.Reason)"
}

if ($errors.Count -gt 0) {
    throw "Phase-boundary intake failed before $Boundary`:`n- $($errors -join "`n- ")"
}

Write-Output "Phase-boundary intake passed before ${Boundary}: $($intakeNotes.Count) changed proposal/handoff note(s) examined since $baseCommit."
foreach ($result in $results) {
    Write-Output "- $result"
}
