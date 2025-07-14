# Mutex Disruptor — Cleans up mutexes stealthily
$targetMutexes = @("Global\\AdobeUpdater", "Global\\AV_Scan", "Global\\BG_Shield")
foreach ($m in $targetMutexes) {
  try {
    $mobj = New-Object System.Threading.Mutex($false, $m, [ref]$created)
    if (-not $created) {
      Write-Output "[$m] was active. Attempted takeover."
    }
    $mobj.Close()
  } catch {
    Write-Output "[$m] not accessible or already removed."
  }
}
