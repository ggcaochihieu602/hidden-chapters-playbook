# Cai skill Codex va LATEST tu ban playbook nay. Chay bang update.bat
$root = Split-Path -Parent $PSScriptRoot
$dst = Join-Path $env:USERPROFILE '.codex\skills\mp2-brief-edit'
$ref = Join-Path $dst 'references\playbook-current'
New-Item -ItemType Directory -Force -Path $ref | Out-Null
Copy-Item (Join-Path $PSScriptRoot 'installed-SKILL.md') (Join-Path $dst 'SKILL.md') -Force
# Path map for machines where E:\Youtube AI does not exist (written by setup\setup.ps1)
$ws = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $root))
$lp = Join-Path $ws 'LOCAL_PATHS.json'
if ((Test-Path $lp) -and -not (Test-Path 'E:\Youtube AI\Hidden Chapters\Playbooks')) {
  $note = "`n`nLocal path map (this machine): wherever this skill or the playbook says E:\Youtube AI use $ws; E:\Tool use $ws\Tool; C:\Users\OS use $env:USERPROFILE. Full map: $lp and $ws\AGENTS.md.`n"
  Add-Content -LiteralPath (Join-Path $dst 'SKILL.md') -Value $note -Encoding utf8
}
robocopy $root $ref /MIR /XD .git tools setup /XF .gitignore /NFL /NDL /NJH /NJS | Out-Null
$parent = Split-Path -Parent $root
Copy-Item (Join-Path $PSScriptRoot 'LATEST.json') (Join-Path $parent 'LATEST.json') -Force
Copy-Item (Join-Path $PSScriptRoot 'LATEST.md') (Join-Path $parent 'LATEST.md') -Force
"Da cai skill vao $dst va cap nhat LATEST o $parent"
