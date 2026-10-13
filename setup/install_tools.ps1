# Hidden Chapters - set up a new machine (step 2: install tools). Safe to run again; skips what is already there.
# Usage: powershell -ExecutionPolicy Bypass -File setup\install_tools.ps1 [-ResolveFree] [-SkipVoice] [-SkipFrenemy] [-SkipResolveMcp]
param(
  [switch]$ResolveFree,
  [switch]$SkipVoice,
  [switch]$SkipFrenemy,
  [switch]$SkipResolveMcp
)
$ErrorActionPreference = 'Continue'
function Say($m) { Write-Host "[install] $m" }
function Has($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }
function RefreshPath { $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User') }

$paths = Get-Content -Raw (Join-Path (Split-Path -Parent (Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)))) 'LOCAL_PATHS.json') | ConvertFrom-Json
$Root = $paths.workspace_root
Say "workspace root: $Root"

# 1. Base tools via winget (Git, Node LTS, Python 3.12, FFmpeg)
$winget = Has 'winget'
function WingetInstall($id, $check) {
  if (Has $check) { Say "$check already installed"; return }
  if (-not $winget) { Say "MISSING $check and winget is not available: install $id by hand"; return }
  Say "installing $id ..."
  winget install --id $id -e --accept-package-agreements --accept-source-agreements --silent
  RefreshPath
}
WingetInstall 'Git.Git' 'git'
WingetInstall 'OpenJS.NodeJS.LTS' 'node'
if (-not (Has 'py')) { WingetInstall 'Python.Python.3.12' 'py' } else { Say "py launcher present" }
WingetInstall 'Gyan.FFmpeg' 'ffmpeg'
RefreshPath
$py312 = $null
try { $py312 = & py -3.12 -c "import sys;print(sys.executable)" 2>$null } catch {}
if (-not $py312) { if ($winget) { winget install --id Python.Python.3.12 -e --accept-package-agreements --accept-source-agreements --silent; RefreshPath; $py312 = & py -3.12 -c "import sys;print(sys.executable)" 2>$null } }
if (-not $py312) { Say "MISSING Python 3.12 (needed for Resolve MCP and OmniVoice)"; } else { Say "Python 3.12: $py312" }

# 2. Claude Code (native) and Codex CLI
if (-not (Has 'claude') -and -not (Test-Path (Join-Path $env:USERPROFILE '.local\bin\claude.exe'))) {
  Say "installing Claude Code (official installer) ..."
  try { Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression } catch { Say "Claude Code install failed: $($_.Exception.Message)" }
  $env:Path = (Join-Path $env:USERPROFILE '.local\bin') + ';' + $env:Path
} else { Say "Claude Code present" }
if (-not (Has 'codex')) {
  if (Has 'npm') { Say "installing Codex CLI ..."; npm install -g @openai/codex; RefreshPath } else { Say "MISSING npm, cannot install Codex CLI" }
} else { Say "Codex CLI present" }

# 3. DaVinci Resolve MCP
$mcp = $paths.resolve_mcp
if (-not $SkipResolveMcp) {
  if (-not (Test-Path (Join-Path $mcp '.git'))) {
    Say "cloning davinci-resolve-mcp ..."
    git clone https://github.com/samuelgursky/davinci-resolve-mcp.git "$mcp"
  } else { Say "davinci-resolve-mcp already cloned (git pull to update)"; git -C "$mcp" pull --ff-only }
  $venvPy = Join-Path $mcp 'venv\Scripts\python.exe'
  if (-not (Test-Path $venvPy) -and $py312) { & py -3.12 -m venv (Join-Path $mcp 'venv') }
  if (Test-Path $venvPy) {
    & $venvPy -m pip install --upgrade pip
    & $venvPy -m pip install -r (Join-Path $mcp 'requirements.txt')
    if ($ResolveFree) {
      Say "installing the in-app bridge for DaVinci Resolve free edition ..."
      Push-Location $mcp; & $venvPy scripts\install_resolve_bridge.py; Pop-Location
    }
  }
}

# 4. Frenemy (Codex -> Claude relay)
$fr = $paths.frenemy
if (-not $SkipFrenemy) {
  if (-not (Test-Path (Join-Path $fr '.git'))) { Say "cloning frenemy ..."; git clone https://github.com/noblehacks/frenemy.git "$fr" }
  else { Say "frenemy already cloned" }
  $claudeOk = (Has 'claude') -or (Test-Path (Join-Path $env:USERPROFILE '.local\bin\claude.exe'))
  if ($claudeOk -and (Has 'codex') -and (Has 'node')) {
    Push-Location $fr; powershell -NoProfile -ExecutionPolicy Bypass -File install.ps1; Pop-Location
  } else { Say "SKIP frenemy install.ps1: needs node, claude and codex on PATH. Sign in to claude and codex, then run this script again." }
}

# 5. OmniVoice (needs an NVIDIA GPU for reasonable speed)
if (-not $SkipVoice -and $py312) {
  $vv = Join-Path $Root '.voice-venv'
  $vpy = Join-Path $vv 'Scripts\python.exe'
  if (-not (Test-Path $vpy)) { & py -3.12 -m venv $vv }
  & $vpy -m pip install --upgrade pip
  & $vpy -m pip install torch==2.8.0 torchaudio==2.8.0 --index-url https://download.pytorch.org/whl/cu128
  & $vpy -m pip install omnivoice==0.2.1 soundfile huggingface_hub
  $model = $paths.omnivoice_model
  if (-not (Test-Path (Join-Path $model 'model.safetensors'))) {
    Say "downloading OmniVoice model (about 3 GB) ..."
    & $vpy -c "from huggingface_hub import snapshot_download; snapshot_download('k2-fsa/OmniVoice', local_dir=r'$model')"
  } else { Say "OmniVoice model already present" }
  & $vpy -c "import torch;print('CUDA available:', torch.cuda.is_available())"
}

Say "DONE step 2. Next: sign-ins (see SETUP_PROCESS.md step 4), setup\set_api_keys.ps1, setup\verify.ps1"
