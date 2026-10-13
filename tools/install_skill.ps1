# Cai skill Codex va LATEST tu ban playbook nay. Chay bang update.bat
$root = Split-Path -Parent $PSScriptRoot
$dst = Join-Path $env:USERPROFILE '.codex\skills\mp2-brief-edit'
$ref = Join-Path $dst 'references\playbook-current'
New-Item -ItemType Directory -Force -Path $ref | Out-Null
Copy-Item (Join-Path $PSScriptRoot 'installed-SKILL.md') (Join-Path $dst 'SKILL.md') -Force
robocopy $root $ref /MIR /XD .git tools /XF .gitignore /NFL /NDL /NJH /NJS | Out-Null
$parent = Split-Path -Parent $root
Copy-Item (Join-Path $PSScriptRoot 'LATEST.json') (Join-Path $parent 'LATEST.json') -Force
Copy-Item (Join-Path $PSScriptRoot 'LATEST.md') (Join-Path $parent 'LATEST.md') -Force
"Da cai skill vao $dst va cap nhat LATEST o $parent"
