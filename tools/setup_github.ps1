# Day playbook len GitHub lan dau. Chay bang setup_github.bat
$root = Split-Path -Parent $PSScriptRoot
$log = Join-Path $PSScriptRoot 'setup_github.log'
Start-Transcript -Path $log -Force | Out-Null
Set-Location $root
git --version
if ($LASTEXITCODE -ne 0) { 'RESULT=GIT_MISSING'; Stop-Transcript | Out-Null; exit 1 }
$remote = (Get-Content (Join-Path $PSScriptRoot 'github_remote.txt') -Raw).Trim()
if (-not (Test-Path (Join-Path $root '.git'))) { git init }
if (-not (git config user.name)) { git config user.name "Cao" }
if (-not (git config user.email)) { git config user.email "caochihieu506@gmail.com" }
git add -A
git commit -m "Playbook ver 33"
git branch -M main
$hasOrigin = git remote | Where-Object { $_ -eq 'origin' }
if ($hasOrigin) { git remote set-url origin $remote } else { git remote add origin $remote }
git push -u origin main
"RESULT=PUSH_EXIT_$LASTEXITCODE"
Stop-Transcript | Out-Null
