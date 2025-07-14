# Entropy Logger - Monitors randomness from keypresses/mouse
Add-Type -AssemblyName System.Windows.Forms
$log = "$env:TEMP\\entropy.log"
while ($true) {
  $x = [System.Windows.Forms.Cursor]::Position.X
  $y = [System.Windows.Forms.Cursor]::Position.Y
  $time = Get-Date
  "$time : $x,$y" >> $log
  Start-Sleep -Milliseconds (Get-Random -Min 80 -Max 160)
}
