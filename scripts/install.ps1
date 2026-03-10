param(
    [string]$TargetSkillsDir
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceSkillsDir = Join-Path $repoRoot "skills"

if (-not (Test-Path $sourceSkillsDir)) {
    throw "Could not find source skills directory at $sourceSkillsDir"
}

if (-not $TargetSkillsDir) {
    if ($env:CODEX_HOME) {
        $TargetSkillsDir = Join-Path $env:CODEX_HOME "skills"
    } else {
        $TargetSkillsDir = Join-Path $HOME ".codex\skills"
    }
}

New-Item -ItemType Directory -Force -Path $TargetSkillsDir | Out-Null

$skillDirs = Get-ChildItem $sourceSkillsDir -Directory | Sort-Object Name

Write-Host ""
Write-Host "Installing Fabric CLI skills pack" -ForegroundColor Cyan
Write-Host "Source: $sourceSkillsDir"
Write-Host "Target: $TargetSkillsDir"
Write-Host ""

foreach ($skillDir in $skillDirs) {
    $targetDir = Join-Path $TargetSkillsDir $skillDir.Name
    if (Test-Path $targetDir) {
        Remove-Item -Recurse -Force $targetDir
    }
    Copy-Item -Recurse -Force $skillDir.FullName $targetDir
    Write-Host ("Installed {0}" -f $skillDir.Name) -ForegroundColor Green
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host "Restart Codex if it is already open, then use prompts like:" -ForegroundColor Yellow
Write-Host '  Use $fab-bootstrap to install Fabric CLI and set up user login.'
Write-Host '  Use $fab-discovery to inspect my Fabric workspace.'
