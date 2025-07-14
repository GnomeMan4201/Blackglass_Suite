# Rainbow Forkbomb
$colors = "Red","Green","Yellow","Blue","Cyan","Magenta"
1..5 | ForEach-Object {
  $c = Get-Random -InputObject $colors
  Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'BLACKGLASS!' -ForegroundColor $c"
  Start-Sleep -Milliseconds 300
}
