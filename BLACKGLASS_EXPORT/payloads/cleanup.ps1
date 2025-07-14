# Cleanup - Erase recon traces and shell history
$paths = @("$env:TEMP\\recon.ps1", "$env:TEMP\\*.log", "$env:USERPROFILE\\recent", "$env:APPDATA\\Microsoft\\Windows\\Recent")
foreach ($p in $paths) {
  Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue
}
Clear-History
