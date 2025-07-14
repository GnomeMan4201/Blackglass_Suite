# Prank Soundloop - Plays system sounds randomly
Add-Type -AssemblyName PresentationCore
$sounds = @([System.Media.SystemSounds]::Asterisk, [System.Media.SystemSounds]::Beep, [System.Media.SystemSounds]::Exclamation)
while ($true) {
  ($sounds | Get-Random).Play()
  Start-Sleep -Milliseconds (Get-Random -Minimum 500 -Maximum 1200)
}
