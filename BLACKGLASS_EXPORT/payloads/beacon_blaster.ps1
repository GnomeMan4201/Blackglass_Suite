$target = "192.168.1.255"
1..5 | ForEach-Object {
  msg * "Update $($_)"
  ping -n 1 $target > $null
  Start-Sleep -Milliseconds 500
}
