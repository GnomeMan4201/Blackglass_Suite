# Recon - Full system, network, and user recon
$out = "$env:TEMP\\sys_recon.log"
Get-ComputerInfo | Out-File $out
whoami >> $out
Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true} >> $out
Get-Process | Sort CPU -Descending | Select -First 5 >> $out
Get-ChildItem "$env:USERPROFILE\\Documents" -Recurse -ErrorAction SilentlyContinue >> $out
