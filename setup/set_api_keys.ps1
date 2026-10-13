# Hidden Chapters - save Pixabay / Pexels API keys encrypted for this Windows user (DPAPI).
# Run it yourself in a PowerShell window; the key is typed hidden and never printed or written in plain text.
# Usage: powershell -ExecutionPolicy Bypass -File setup\set_api_keys.ps1
$dir = Join-Path $env:USERPROFILE '.codex\secrets'
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
foreach ($name in @('pixabay','pexels')) {
  $file = Join-Path $dir "$name-api-key.dpapi"
  $have = Test-Path $file
  $prompt = if ($have) { "$name API key (Enter to keep the saved one)" } else { "$name API key" }
  $sec = Read-Host -AsSecureString $prompt
  if ($sec.Length -eq 0) { if ($have) { Write-Host "kept $name key" } else { Write-Host "SKIPPED $name (no key)" }; continue }
  $sec | ConvertFrom-SecureString | Set-Content -LiteralPath $file -Encoding ascii
  Write-Host "saved $name key to $file (encrypted)"
}
