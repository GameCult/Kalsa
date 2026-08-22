param(
    [string]$VaultRoot
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $VaultRoot) {
    $VaultRoot = Join-Path $repoRoot "Kalsa"
}
$vaultFull = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\', '/')
if (-not (Test-Path -LiteralPath $vaultFull -PathType Container)) {
    throw "Kalsa vault root not found: $vaultFull"
}

$errors = @()
$allowedDirectories = @('Public', 'Spoilers', '.obsidian')
$allowedFiles = @('index.md')
foreach ($item in Get-ChildItem -LiteralPath $vaultFull -Force) {
    if ($item.PSIsContainer) {
        if ($item.Name -notin $allowedDirectories) {
            $errors += "unexpected top-level directory: $($item.Name)"
        }
    }
    elseif ($item.Name -notin $allowedFiles) {
        $errors += "unexpected top-level file: $($item.Name)"
    }
}

$readerIndex = Join-Path $vaultFull 'Public\index.md'
$spoilerIndex = Join-Path $vaultFull 'Spoilers\index.md'
$rootIndex = Join-Path $vaultFull 'index.md'
foreach ($path in @($readerIndex, $spoilerIndex, $rootIndex)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors += "required vault entrance missing: $path"
    }
}

if (Test-Path -LiteralPath $rootIndex -PathType Leaf) {
    $rootText = Get-Content -Raw -LiteralPath $rootIndex -Encoding utf8
    if ($rootText -notmatch '\[\[Public/index(?:\||\]\])') {
        $errors += "root index does not lead to Public/index"
    }
    if ($rootText -notmatch '\[\[Spoilers/index(?:\||\]\])') {
        $errors += "root index does not mark a deliberate Spoilers/index path"
    }
}

$obsidianRoot = Join-Path $vaultFull '.obsidian'
foreach ($sessionName in @('workspace.json', 'workspace-mobile.json', 'workspaces.json')) {
    $sessionPath = Join-Path $obsidianRoot $sessionName
    if (Test-Path -LiteralPath $sessionPath -PathType Leaf) {
        $sessionText = Get-Content -Raw -LiteralPath $sessionPath -Encoding utf8
        if ($sessionText -match '(?i)Spoilers[/\\]') {
            $errors += "Obsidian session state bypasses the spoiler gate: .obsidian/$sessionName"
        }
    }
}

foreach ($note in Get-ChildItem -LiteralPath $vaultFull -Recurse -File -Filter '*.md') {
    $relative = $note.FullName.Substring($vaultFull.Length).TrimStart('\', '/') -replace '\\', '/'
    if ($relative -ne 'index.md' -and
        -not $relative.StartsWith('Public/', [System.StringComparison]::OrdinalIgnoreCase) -and
        -not $relative.StartsWith('Spoilers/', [System.StringComparison]::OrdinalIgnoreCase)) {
        $errors += "Markdown outside the reader or spoiler sections: $relative"
    }
}

if ($errors.Count -gt 0) {
    throw "Vault-layout verification failed:`n- $($errors -join "`n- ")"
}

Write-Output "Vault layout passed: casual exploration is limited to Public, Spoilers, and the navigation-only root index."
