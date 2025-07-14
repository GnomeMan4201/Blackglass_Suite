Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object Drawing.Bitmap $bounds.Width, $bounds.Height
$gfx = [Drawing.Graphics]::FromImage($bitmap)
$gfx.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.Size)

$outPath = "$env:TEMP\\screenshot.png"
$bitmap.Save($outPath)

if (Test-Path "$env:ProgramFiles\\Microsoft\\Edge\\Application\\msedge.exe") {
    Start-Process "$env:ProgramFiles\\Microsoft\\Edge\\Application\\msedge.exe" -ArgumentList "--app=file:///$outPath"
} else {
    $form = New-Object Windows.Forms.Form
    $form.Text = "Screenshot Preview"
    $form.BackgroundImage = [System.Drawing.Image]::FromFile($outPath)
    $form.BackgroundImageLayout = "Stretch"
    $form.WindowState = "Maximized"
    $form.TopMost = $true
    $form.ShowDialog()
}
