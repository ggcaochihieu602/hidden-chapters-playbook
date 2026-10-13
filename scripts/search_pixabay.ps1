param([Parameter(Mandatory=$true)][ValidateLength(1,100)][string]$Query, [Parameter(Mandatory=$true)][string]$CacheDirectory)
$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Path $CacheDirectory -Force | Out-Null
$hashProvider = [Security.Cryptography.SHA256]::Create()
$hash = [BitConverter]::ToString($hashProvider.ComputeHash([Text.Encoding]::UTF8.GetBytes($Query))).Replace('-','').ToLowerInvariant()
$cacheFile = Join-Path $CacheDirectory ($hash + '.json')
if ((Test-Path -LiteralPath $cacheFile) -and ((Get-Date) - (Get-Item -LiteralPath $cacheFile).LastWriteTime).TotalHours -lt 24) { Get-Content -LiteralPath $cacheFile -Raw; exit 0 }
$credentialFile = Join-Path $env:USERPROFILE '.codex\secrets\pixabay-api-key.dpapi'
$secureKey = Get-Content -LiteralPath $credentialFile -Raw | ConvertTo-SecureString
$keyPointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureKey)
try {
    $key = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($keyPointer)
    $uri = 'https://pixabay.com/api/videos/?key=' + [Uri]::EscapeDataString($key) + '&q=' + [Uri]::EscapeDataString($Query) + '&per_page=20&safesearch=true'
    try { $response = Invoke-RestMethod -Uri $uri -TimeoutSec 30 } catch { throw 'Pixabay request failed. Check access/rate limit; request URL and credential suppressed.' }
    $output = [ordered]@{ provider='Pixabay'; query=$Query; retrieved_at=(Get-Date).ToUniversalTime().ToString('o'); result=$response } | ConvertTo-Json -Depth 15
    Set-Content -LiteralPath $cacheFile -Value $output -Encoding UTF8
    Write-Output $output
} finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($keyPointer); $key=$null; $uri=$null }
