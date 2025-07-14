# Chaos UI Overlay - Annoying UI flood
Add-Type -AssemblyName System.Windows.Forms
1..5 | ForEach-Object {
  $form = New-Object Windows.Forms.Form
  $form.Text = "BLACKGLASS"
  $form.Size = '200,100'
  $form.TopMost = $true
  $form.Show()
}
