#!/bin/bash
cd ~/blackglass_forge
latest_forge=$(ls -1 qr_payload_forge*.sh 2>/dev/null | sort -V | tail -n1)

if [ -z "$latest_forge" ]; then
  echo "[!] No QR Payload Forge scripts found."
  exit 1
fi

echo "[*] Launching latest QR Payload Forge: $latest_forge"
chmod +x "$latest_forge"
./"$latest_forge"
