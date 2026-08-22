param(
    [ValidateSet("build", "dev")]
    [string]$Command = "dev"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$sharedQuartzRoot = if ($env:GAMECULT_QUARTZ_ROOT) {
    $env:GAMECULT_QUARTZ_ROOT
} else {
    Join-Path (Split-Path -Parent $repoRoot) "GameCult-Quartz"
}
$portableNodeRoot = Join-Path $repoRoot ".tools\node-v24.15.0-win-x64"
$portableNode = Join-Path $portableNodeRoot "node.exe"

# Prefer the bundled Windows runtime when present, then fall back to Node on PATH.
if (Test-Path $portableNode) {
    $node = $portableNode
    $env:PATH = "$portableNodeRoot;$env:PATH"
} else {
    $nodeCommand = Get-Command node -ErrorAction SilentlyContinue
    if (-not $nodeCommand) {
        throw "node was not found. Install Node.js or restore the portable runtime under .tools."
    }

    $node = $nodeCommand.Source
}

$env:npm_config_cache = Join-Path $repoRoot ".npm-cache"

if (-not (Test-Path $sharedQuartzRoot)) {
    throw "GameCult-Quartz was not found at '$sharedQuartzRoot'. Clone it beside this repo or set GAMECULT_QUARTZ_ROOT."
}

$buildScript = Join-Path $sharedQuartzRoot "scripts\build-site.mjs"
$outputRelative = "quartz-site/public"
$outputRoot = [System.IO.Path]::GetFullPath((Join-Path $repoRoot "quartz-site"))
$outputFull = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $outputRelative))

if (-not (Test-Path $buildScript)) {
    throw "GameCult-Quartz build script was not found at '$buildScript'."
}

if (-not $outputFull.StartsWith($outputRoot + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Quartz output must remain below '$outputRoot'."
}

# Quartz emitters replace the reader projection. Old author-vault pages must not
# survive merely because the next source tree is smaller.
if (Test-Path -LiteralPath $outputFull) {
    Remove-Item -LiteralPath $outputFull -Recurse -Force
}

$scriptArgs = @(
    $buildScript,
    $Command,
    "--siteRoot", $repoRoot,
    "--overlayDir", "site",
    "--contentDir", "Kalsa/Public",
    "--outputDir", $outputRelative
)

& $node @scriptArgs
