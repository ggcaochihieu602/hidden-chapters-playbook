# Hidden Chapters - set up a new machine (step 1: folders, files, paths, skill, Codex config)
# Safe to run many times. Never deletes or overwrites the user's own files.
# Usage (from the workspace root):  powershell -ExecutionPolicy Bypass -File "Hidden Chapters\Playbooks\Playbook ver 33\setup\setup.ps1"
param(
  [string]$Root = ""
)
$ErrorActionPreference = 'Stop'
$Utf8 = New-Object System.Text.UTF8Encoding $false
function Say($m) { Write-Host "[setup] $m" }
function WriteText($path, $text) { [IO.File]::WriteAllText($path, $text, $Utf8) }
function EnsureDir($p) { if (-not (Test-Path -LiteralPath $p)) { New-Item -ItemType Directory -Force -Path $p | Out-Null; Say "created $p" } }
function CopyIfMissing($src, $dst) {
  if (-not (Test-Path -LiteralPath $src)) { Say "WARN missing source $src"; return }
  if (Test-Path -LiteralPath $dst) { return }
  EnsureDir (Split-Path -Parent $dst)
  Copy-Item -LiteralPath $src -Destination $dst
  Say "copied $(Split-Path -Leaf $dst)"
}

$Repo = Split-Path -Parent $PSScriptRoot          # ...\Playbook ver 33
$Assets = Join-Path $PSScriptRoot 'assets'
$PlaybookName = Split-Path -Leaf $Repo

# 1. Find the workspace root (W)
$expectedTail = '\Hidden Chapters\Playbooks\' + $PlaybookName
if ($Root -eq "") {
  if ($Repo.EndsWith($expectedTail, [StringComparison]::OrdinalIgnoreCase)) {
    $Root = $Repo.Substring(0, $Repo.Length - $expectedTail.Length)
  } else {
    $Root = (Get-Location).Path
  }
}
$Root = (Resolve-Path -LiteralPath $Root).Path.TrimEnd('\')
Say "workspace root: $Root"

$HC = Join-Path $Root 'Hidden Chapters'
$PB = Join-Path $HC 'Playbooks'
$PlaybookDir = Join-Path $PB $PlaybookName
if (-not ($Repo.TrimEnd('\') -ieq $PlaybookDir)) {
  Say "playbook repo is at $Repo, expected $PlaybookDir"
  if (Test-Path -LiteralPath $PlaybookDir) { throw "Target $PlaybookDir already exists. Move the clone there by hand and run again." }
  EnsureDir $PB
  robocopy $Repo $PlaybookDir /E /NFL /NDL /NJH /NJS | Out-Null
  Say "copied the playbook (with .git) to $PlaybookDir. From now on use that copy; you may delete $Repo."
}

# 2. Folder structure (same layout as the original machine)
$dirs = @(
  $HC, $PB,
  (Join-Path $HC 'Text example'), (Join-Path $HC 'Claude script'), (Join-Path $HC 'Script sample'), (Join-Path $HC 'Template Studies'),
  (Join-Path $Root 'MoneyPrinter2'), (Join-Path $Root 'MoneyPrinter2\artifacts'), (Join-Path $Root 'MoneyPrinter2\artifacts\script-ideal'),
  (Join-Path $Root 'MoneyPrinter2\research'), (Join-Path $Root 'MoneyPrinter2\scripts'), (Join-Path $Root 'MoneyPrinter2\Downloads'), (Join-Path $Root 'MoneyPrinter2\docs'),
  (Join-Path $Root 'data\models\omnivoice\voice-presets'), (Join-Path $Root 'Tool')
)
foreach ($d in $dirs) { EnsureDir $d }

# 3. Files the playbook expects outside its own folder
$v = Join-Path $PlaybookDir 'visuals'
CopyIfMissing (Join-Path $v 'text-example-v32\Annotation.png') (Join-Path $HC 'Text example\Annotation.png')
CopyIfMissing (Join-Path $v 'text-example-v32\Chapter.png')    (Join-Path $HC 'Text example\Chapter.png')
CopyIfMissing (Join-Path $v 'text-example-v32\Location.png')   (Join-Path $HC 'Text example\location.png')
foreach ($b in @('logo.png','logo overlay.png','4k Icon.png','Thumb Sample1.jpg','Thumb Sample2.jpg','Thumb Sample3.jpg')) {
  CopyIfMissing (Join-Path $v "brand\$b") (Join-Path $HC $b)
}
CopyIfMissing (Join-Path $PlaybookDir 'templates\NEW_VIDEO_PROMPT.txt') (Join-Path $HC 'NEW_VIDEO_PROMPT.txt')
CopyIfMissing (Join-Path $PlaybookDir 'reference\examples\STOCK FOOTAGE & MUSIC KEYWORDS.txt') (Join-Path $HC 'STOCK FOOTAGE & MUSIC KEYWORDS.txt')
CopyIfMissing (Join-Path $Assets 'hidden-chapters\NEW_VIDEO_START.md') (Join-Path $HC 'NEW_VIDEO_START.md')
CopyIfMissing (Join-Path $Assets 'hidden-chapters\OUTPUT_RULES.md') (Join-Path $HC 'OUTPUT_RULES.md')
CopyIfMissing (Join-Path $Assets 'hidden-chapters\AI_THUMBNAIL_PROMPT_RULES.md') (Join-Path $HC 'AI_THUMBNAIL_PROMPT_RULES.md')
CopyIfMissing (Join-Path $Assets 'moneyprinter2\AGENTS.md') (Join-Path $Root 'MoneyPrinter2\AGENTS.md')
CopyIfMissing (Join-Path $Assets 'moneyprinter2\SCRIPT_IDEAL_RULES.md') (Join-Path $Root 'MoneyPrinter2\artifacts\script-ideal\SCRIPT_IDEAL_RULES.md')
CopyIfMissing (Join-Path $Assets 'moneyprinter2\omni_voice_worker.py') (Join-Path $Root 'MoneyPrinter2\scripts\omni_voice_worker.py')
CopyIfMissing (Join-Path $Assets 'voice\am_adam.wav') (Join-Path $Root 'data\models\omnivoice\voice-presets\am_adam.wav')

# 4. Make the playbook's absolute paths (E:\Youtube AI, E:\Tool) work on this machine
$junctionNote = "none"
if (-not ($Root -ieq 'E:\Youtube AI')) {
  if ((Test-Path 'E:\') -and -not (Test-Path 'E:\Youtube AI')) {
    New-Item -ItemType Junction -Path 'E:\Youtube AI' -Target $Root | Out-Null
    Say "created junction E:\Youtube AI -> $Root"
    $junctionNote = "E:\Youtube AI -> $Root"
  } else {
    Say "no junction for E:\Youtube AI (no E: drive or it already exists); agents use the path map in AGENTS.md"
  }
}
if (-not (Test-Path 'E:\Tool') -and (Test-Path 'E:\')) {
  New-Item -ItemType Junction -Path 'E:\Tool' -Target (Join-Path $Root 'Tool') | Out-Null
  Say "created junction E:\Tool -> $Root\Tool"
}
$eWorks = Test-Path 'E:\Youtube AI\Hidden Chapters\Playbooks'

$paths = [ordered]@{
  workspace_root = $Root
  playbook = $PlaybookDir
  hidden_chapters = $HC
  moneyprinter2 = (Join-Path $Root 'MoneyPrinter2')
  frenemy = (Join-Path $Root 'Tool\frenemy')
  resolve_mcp = (Join-Path $Root 'MoneyPrinter2\research\davinci-resolve-mcp')
  voice_python = (Join-Path $Root '.voice-venv\Scripts\python.exe')
  omnivoice_model = (Join-Path $Root 'data\models\omnivoice')
  omnivoice_presets = (Join-Path $Root 'data\models\omnivoice\voice-presets')
  user_home = $env:USERPROFILE
  e_drive_paths_work = $eWorks
  junction = $junctionNote
}
WriteText (Join-Path $Root 'LOCAL_PATHS.json') (($paths | ConvertTo-Json) + "`n")

# 5. Workspace AGENTS.md (Codex reads it automatically). Managed block only; user text outside it is kept.
$map = if ($eWorks) { "E:\Youtube AI\... works as written on this machine (it points to $Root)." } else { "This machine has no usable E:\Youtube AI. Wherever the playbook writes E:\Youtube AI read $Root; E:\Tool read $Root\Tool; C:\Users\OS read $env:USERPROFILE." }
$block = @"
<!-- HC-SETUP:BEGIN (managed by setup.ps1, do not edit inside) -->
# Hidden Chapters production workspace

Before any documentary task: read Hidden Chapters/Playbooks/LATEST.json, open that playbook's START_HERE.md, then only the current stage. The skill mp2-brief-edit routes to the same workflow.

## Path map for this machine
- $map
- Workspace root: $Root
- Playbook: $PlaybookDir
- Film folders: $HC\YYYY-M-D-Title
- Production artifacts: $Root\MoneyPrinter2\artifacts
- DaVinci Resolve MCP repo: $Root\MoneyPrinter2\research\davinci-resolve-mcp
- Frenemy (Claude relay): $Root\Tool\frenemy
- API keys (DPAPI, never print): $env:USERPROFILE\.codex\secrets\pixabay-api-key.dpapi, pexels-api-key.dpapi. Use the playbook's scripts\search_pixabay.ps1 and scripts\search_pexels.ps1.

## Voice (OmniVoice)
Write a request JSON, then run: "$Root\.voice-venv\Scripts\python.exe" "$Root\MoneyPrinter2\scripts\omni_voice_worker.py" request.json
Request fields: model = "$Root\data\models\omnivoice", voice = "am_adam", preset_root = "$Root\data\models\omnivoice\voice-presets", language = "en", speed = 0.8, items = [{ text, output }]. Generate one master WAV from the whole locked script.

## Ground rules
Never print or store cookies, tokens, passwords or API keys. Epidemic Sound and GetHinh are signed in inside the Codex in-app browser; do not check plans or rights, if it downloads, use it.
<!-- HC-SETUP:END -->
"@
$agents = Join-Path $Root 'AGENTS.md'
if (Test-Path -LiteralPath $agents) {
  $old = [IO.File]::ReadAllText($agents)
  $pattern = '(?s)<!-- HC-SETUP:BEGIN.*?<!-- HC-SETUP:END -->'
  if ($old -match $pattern) { $new = [regex]::Replace($old, $pattern, [Text.RegularExpressions.MatchEvaluator]{ param($m) $block }) }
  else { $new = $old.TrimEnd() + "`n`n" + $block + "`n" }
  WriteText $agents $new
} else { WriteText $agents ($block + "`n") }
Say "wrote AGENTS.md path map"

# 6. Codex skill + LATEST pointers
& (Join-Path $PlaybookDir 'tools\install_skill.ps1')

# 7. Codex config: trust the workspace and register the DaVinci Resolve MCP (backup first, append only)
$codexDir = Join-Path $env:USERPROFILE '.codex'
EnsureDir $codexDir
$cfg = Join-Path $codexDir 'config.toml'
if (-not (Test-Path -LiteralPath $cfg)) { WriteText $cfg "" }
$cfgText = [IO.File]::ReadAllText($cfg)
Copy-Item -LiteralPath $cfg -Destination ($cfg + '.bak-hc-setup') -Force
$add = ""
$projKey = $Root.ToLower()
if ($cfgText -notmatch [regex]::Escape("[projects.'$projKey']")) {
  $add += "`n[projects.'$projKey']`ntrust_level = `"trusted`"`n"
}
if ($cfgText -notmatch '\[mcp_servers\.davinci-resolve\]') {
  $mcp = (Join-Path $Root 'MoneyPrinter2\research\davinci-resolve-mcp').Replace('\','\\')
  $add += @"

[mcp_servers.davinci-resolve]
command = "$mcp\\venv\\Scripts\\python.exe"
args = ["$mcp\\src\\server.py"]
env = { RESOLVE_SCRIPT_API = "C:\\ProgramData\\Blackmagic Design\\DaVinci Resolve\\Support\\Developer\\Scripting", RESOLVE_SCRIPT_LIB = "C:\\Program Files\\Blackmagic Design\\DaVinci Resolve\\fusionscript.dll", PYTHONPATH = "C:\\ProgramData\\Blackmagic Design\\DaVinci Resolve\\Support\\Developer\\Scripting\\Modules" }
"@
}
if ($add -ne "") { WriteText $cfg ($cfgText.TrimEnd() + "`n" + $add); Say "updated Codex config.toml (backup: config.toml.bak-hc-setup)" }
else { Say "Codex config.toml already has the workspace and davinci-resolve entries" }

Say "DONE step 1. Next: setup\install_tools.ps1, then setup\set_api_keys.ps1, then setup\verify.ps1"
