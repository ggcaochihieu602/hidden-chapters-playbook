# Hidden Chapters - check that this machine is ready. Prints PASS/WARN/FAIL and writes setup\verify-result.json (no secrets).
$ErrorActionPreference = 'Continue'
$paths = Get-Content -Raw (Join-Path (Split-Path -Parent (Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)))) 'LOCAL_PATHS.json') | ConvertFrom-Json
$Root = $paths.workspace_root
$results = @()
function Check($name, $ok, $hint, $level = 'FAIL') {
  $s = if ($ok) { 'PASS' } else { $level }
  $script:results += [pscustomobject]@{ check = $name; status = $s; hint = $(if ($ok) { '' } else { $hint }) }
}
function Has($c) { [bool](Get-Command $c -ErrorAction SilentlyContinue) }
$home2 = $env:USERPROFILE
Check 'git' (Has 'git') 'Run setup\install_tools.ps1'
Check 'node' (Has 'node') 'Run setup\install_tools.ps1'
Check 'ffmpeg' (Has 'ffmpeg') 'Run setup\install_tools.ps1 (Gyan.FFmpeg), then reopen the terminal'
$pyOk = $false; if (Has 'py') { $pyOk = [bool](& py -3.12 -c "print(1)" 2>$null) }
Check 'python 3.12' $pyOk 'Install Python 3.12'
Check 'claude CLI' ((Has 'claude') -or (Test-Path "$home2\.local\bin\claude.exe")) 'Run setup\install_tools.ps1, then run claude once to sign in'
Check 'claude signed in' (Test-Path "$home2\.claude\.credentials.json") 'Open a terminal, run: claude  and sign in with your Claude account' 'WARN'
Check 'codex CLI' (Has 'codex') 'npm install -g @openai/codex'
Check 'codex signed in' (Test-Path "$home2\.codex\auth.json") 'Open Codex and sign in with ChatGPT'
Check 'playbook' (Test-Path (Join-Path $paths.playbook 'START_HERE.md')) 'Clone the repo into Hidden Chapters\Playbooks\Playbook ver 33'
Check 'LATEST.json' (Test-Path (Join-Path $paths.hidden_chapters 'Playbooks\LATEST.json')) 'Run tools\install_skill.ps1'
Check 'Codex skill' (Test-Path "$home2\.codex\skills\mp2-brief-edit\SKILL.md") 'Run tools\install_skill.ps1'
Check 'workspace AGENTS.md' (Test-Path (Join-Path $Root 'AGENTS.md')) 'Run setup\setup.ps1'
Check 'E:\Youtube AI paths' ([bool]$paths.e_drive_paths_work) 'No E: drive: agents use the path map in AGENTS.md' 'WARN'
$cfg = "$home2\.codex\config.toml"; $cfgText = if (Test-Path $cfg) { Get-Content -Raw $cfg } else { '' }
Check 'Codex MCP davinci-resolve' ($cfgText -match '\[mcp_servers\.davinci-resolve\]') 'Run setup\setup.ps1'
Check 'Codex MCP claude (Frenemy)' ($cfgText -match '\[mcp_servers\.claude\]') 'Run setup\install_tools.ps1 after signing in to claude and codex'
Check 'Resolve MCP venv' (Test-Path (Join-Path $paths.resolve_mcp 'venv\Scripts\python.exe')) 'Run setup\install_tools.ps1'
Check 'DaVinci Resolve installed' (Test-Path 'C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe') 'Install DaVinci Resolve (Studio or free)'
Check 'Resolve scripting API' (Test-Path 'C:\ProgramData\Blackmagic Design\DaVinci Resolve\Support\Developer\Scripting\Modules') 'Install/open DaVinci Resolve once'
Check 'Frenemy' (Test-Path (Join-Path $paths.frenemy 'ask-claude-mcp.mjs')) 'Run setup\install_tools.ps1'
Check 'OmniVoice venv' (Test-Path $paths.voice_python) 'Run setup\install_tools.ps1'
Check 'OmniVoice model' (Test-Path (Join-Path $paths.omnivoice_model 'model.safetensors')) 'Run setup\install_tools.ps1'
Check 'Voice preset am_adam' (Test-Path (Join-Path $paths.omnivoice_presets 'am_adam.wav')) 'Run setup\setup.ps1'
if (Test-Path $paths.voice_python) {
  $cuda = & $paths.voice_python -c "import torch;print(torch.cuda.is_available())" 2>$null
  Check 'GPU (CUDA) for OmniVoice' ($cuda -eq 'True') 'No CUDA: voice still works on CPU but is very slow; update the NVIDIA driver' 'WARN'
}
Check 'Pixabay key' (Test-Path "$home2\.codex\secrets\pixabay-api-key.dpapi") 'Run setup\set_api_keys.ps1'
Check 'Pexels key' (Test-Path "$home2\.codex\secrets\pexels-api-key.dpapi") 'Run setup\set_api_keys.ps1'
$results | Format-Table -AutoSize
$out = Join-Path $PSScriptRoot 'verify-result.json'
$results | ConvertTo-Json | Set-Content -LiteralPath $out -Encoding utf8
$fail = ($results | Where-Object status -eq 'FAIL').Count
Write-Host ""
Write-Host "FAIL: $fail   (Epidemic Sound / GetHinh sign-in and Resolve preferences are checked by hand, see SETUP_PROCESS.md)"
