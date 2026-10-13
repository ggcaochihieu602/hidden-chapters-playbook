param([Parameter(Mandatory=$true)][string]$Query, [string]$Out = "")
# Pexels video search. Key is read from the DPAPI file made by setup\set_api_keys.ps1 and never printed.
$ErrorActionPreference = 'Stop'
$credentialFile = Join-Path $env:USERPROFILE '.codex\secrets\pexels-api-key.dpapi'
$secureKey = Get-Content -LiteralPath $credentialFile -Raw | ConvertTo-SecureString
$keyPointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureKey)
try {
    $key = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($keyPointer)
    $uri = 'https://api.pexels.com/videos/search?query=' + [Uri]::EscapeDataString($Query) + '&per_page=20&orientation=landscape'
    $r = Invoke-RestMethod -Uri $uri -Headers @{ Authorization = $key }
    $rows = $r.videos | ForEach-Object {
        $best = $_.video_files | Where-Object { $_.width -ge 1920 } | Sort-Object width -Descending | Select-Object -First 1
        [pscustomobject]@{ id=$_.id; url=$_.url; user=$_.user.name; duration=$_.duration; width=$_.width; height=$_.height; file_width=$best.width; file_link=$best.link }
    }
    if ($Out) { $rows | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $Out -Encoding utf8 } else { $rows | ConvertTo-Json -Depth 4 }
} finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($keyPointer); $key=$null }
