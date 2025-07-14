# Screen Blackout Loop - Periodic black screen prank
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object Windows.Forms.Form
$form.WindowState = "Maximized"
$form.BackColor = "Black"
$form.FormBorderStyle = "None"
$form.TopMost = $true
while ($true) {
  $form.ShowDialog()
  Start-Sleep -Seconds 3
}
