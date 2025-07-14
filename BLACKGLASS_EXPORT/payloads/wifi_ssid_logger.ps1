# WiFi SSID Logger
$log = "$env:TEMP\\ssid_log.txt"
$ssid = netsh wlan show interfaces | Select-String 'SSID'
$timestamp = Get-Date
"$timestamp : $ssid" | Out-File -Append $log
