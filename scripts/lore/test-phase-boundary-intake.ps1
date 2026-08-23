$ErrorActionPreference = 'Stop'

$tempBase = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\', '/')
$fixture = Join-Path $tempBase ("kalsa-phase-intake-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $fixture | Out-Null
$fixtureFull = [System.IO.Path]::GetFullPath($fixture)
if (-not $fixtureFull.StartsWith($tempBase + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'Refusing to create phase-intake fixture outside the system temporary directory'
}

function Invoke-FixtureGit {
    param([Parameter(Mandatory = $true)][string[]]$Arguments)

    $output = & git -C $fixtureFull @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Fixture git command failed: git $($Arguments -join ' ')`n$($output -join "`n")"
    }
    return @($output)
}

function Assert-CheckerFails {
    param(
        [Parameter(Mandatory = $true)][string]$Boundary,
        [Parameter(Mandatory = $true)][string]$Message
    )

    $caught = $false
    try {
        & (Join-Path $PSScriptRoot 'check-phase-boundary-intake.ps1') `
            -Boundary $Boundary `
            -PacketPath 'packet.md' `
            -PassPath 'pass.md' `
            -RepositoryRoot $fixtureFull | Out-Null
    }
    catch {
        $caught = $true
    }
    if (-not $caught) {
        throw $Message
    }
}

try {
    New-Item -ItemType Directory -Path (Join-Path $fixtureFull 'Kalsa\Spoilers\Reference') -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $fixtureFull 'Owner.md') -Encoding utf8 -Value "# Owner`n"
    Invoke-FixtureGit -Arguments @('init', '-b', 'main') | Out-Null
    Invoke-FixtureGit -Arguments @('add', '--', 'Owner.md') | Out-Null
    Invoke-FixtureGit -Arguments @('-c', 'user.name=Kalsa Tests', '-c', 'user.email=kalsa-tests@example.invalid', 'commit', '-m', 'Fixture baseline') | Out-Null
    $baseCommit = ([string](Invoke-FixtureGit -Arguments @('rev-parse', 'HEAD') | Select-Object -First 1)).Trim()
    $ownerHash = (Get-FileHash -LiteralPath (Join-Path $fixtureFull 'Owner.md') -Algorithm SHA1).Hash.ToLowerInvariant()

    Set-Content -LiteralPath (Join-Path $fixtureFull 'packet.md') -Encoding utf8 -Value @"
---
packet_id: TEST-01
candidate_identity: raw-sha1-manifest-recorded-below
---

# Packet

``````text
$ownerHash  Owner.md
``````
"@
    Set-Content -LiteralPath (Join-Path $fixtureFull 'pass.md') -Encoding utf8 -Value @"
---
pass_id: TEST-01
intake_base_commit: $baseCommit
---

# Pass

## Phase-boundary intake

| Proposal or handoff note | Disposition | Reason or destination |
| --- | --- | --- |
"@

    $workingNote = 'Kalsa/Spoilers/Reference/Working Handoff.md'
    Set-Content -LiteralPath (Join-Path $fixtureFull $workingNote) -Encoding utf8 -Value "---`nstatus: adopted-candidate`n---`n`n# Working handoff`n"
    Assert-CheckerFails -Boundary 'review' -Message 'Intake checker failed to reject an untracked handoff outside the packet'
    Invoke-FixtureGit -Arguments @('add', '--', $workingNote) | Out-Null
    Assert-CheckerFails -Boundary 'review' -Message 'Intake checker failed to reject a staged handoff outside the packet'
    Invoke-FixtureGit -Arguments @('reset', 'HEAD', '--', $workingNote) | Out-Null

    Add-Content -LiteralPath (Join-Path $fixtureFull 'pass.md') -Encoding utf8 -Value "| ``$workingNote`` | defer | Route to TEST-02 before integration. |"
    & (Join-Path $PSScriptRoot 'check-phase-boundary-intake.ps1') `
        -Boundary review `
        -PacketPath 'packet.md' `
        -PassPath 'pass.md' `
        -RepositoryRoot $fixtureFull | Out-Null

    $committedNote = 'Kalsa/Spoilers/Reference/Committed Proposal.md'
    Set-Content -LiteralPath (Join-Path $fixtureFull $committedNote) -Encoding utf8 -Value "---`nstatus: proposal`n---`n`n# Committed proposal`n"
    Invoke-FixtureGit -Arguments @('add', '--', $committedNote) | Out-Null
    Invoke-FixtureGit -Arguments @('-c', 'user.name=Kalsa Tests', '-c', 'user.email=kalsa-tests@example.invalid', 'commit', '-m', 'Add proposal during pass') | Out-Null
    Assert-CheckerFails -Boundary 'closure' -Message 'Intake checker failed to reject a committed proposal outside the packet'

    Add-Content -LiteralPath (Join-Path $fixtureFull 'pass.md') -Encoding utf8 -Value "| ``$committedNote`` | reject | Superseded by the named owner record. |"
    & (Join-Path $PSScriptRoot 'check-phase-boundary-intake.ps1') `
        -Boundary closure `
        -PacketPath 'packet.md' `
        -PassPath 'pass.md' `
        -RepositoryRoot $fixtureFull | Out-Null

    $includedNote = 'Kalsa/Spoilers/Reference/Included Handoff.md'
    Set-Content -LiteralPath (Join-Path $fixtureFull $includedNote) -Encoding utf8 -Value "---`ntype: handoff`n---`n`n# Included handoff`n"
    $includedHash = (Get-FileHash -LiteralPath (Join-Path $fixtureFull $includedNote) -Algorithm SHA1).Hash.ToLowerInvariant()
    Add-Content -LiteralPath (Join-Path $fixtureFull 'packet.md') -Encoding utf8 -Value "$includedHash  $includedNote"
    & (Join-Path $PSScriptRoot 'check-phase-boundary-intake.ps1') `
        -Boundary review `
        -PacketPath 'packet.md' `
        -PassPath 'pass.md' `
        -RepositoryRoot $fixtureFull | Out-Null

    Add-Content -LiteralPath (Join-Path $fixtureFull $includedNote) -Encoding utf8 -Value "Changed after freeze."
    Assert-CheckerFails -Boundary 'closure' -Message 'Intake checker failed to reject a packeted handoff changed after freeze'

    Write-Output 'Phase-boundary intake tests passed for committed, staged/working, deferred, rejected, packeted, and post-freeze-changed notes.'
}
finally {
    $resolvedFixture = [System.IO.Path]::GetFullPath($fixtureFull)
    if ($resolvedFixture.StartsWith($tempBase + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase) -and
        ([System.IO.Path]::GetFileName($resolvedFixture) -like 'kalsa-phase-intake-*') -and
        (Test-Path -LiteralPath $resolvedFixture)) {
        Remove-Item -LiteralPath $resolvedFixture -Recurse -Force
    }
}
