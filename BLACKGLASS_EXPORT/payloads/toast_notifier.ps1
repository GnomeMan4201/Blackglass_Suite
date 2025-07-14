Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Shield
$notify.BalloonTipTitle = "⚠️ Security Alert"
$notify.BalloonTipText = "Suspicious activity has been detected."
$notify.Visible = $true
$notify.ShowBalloonTip(4000)
Start-Sleep -Seconds 6
$notify.Dispose()
