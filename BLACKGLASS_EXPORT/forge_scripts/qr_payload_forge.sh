#!/bin/bash
read -p "Payload URL: " URL
python3 -c "import qrcode; qrcode.make('$URL').save('output/qr_payload.png')"
echo "[+] QR code saved: output/qr_payload.png"
