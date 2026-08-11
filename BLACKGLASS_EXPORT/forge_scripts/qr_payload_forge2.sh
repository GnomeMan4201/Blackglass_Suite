#!/usr/bin/env bash
set -euo pipefail

# === BLACKGLASS QR FORGE ENHANCED ===
# Dependencies: python3 + qrcode[pil]; curl/ip are used by optional paths.

OUTPUT_DIR="./output"
SERVER_PID=""
mkdir -p "$OUTPUT_DIR"

if ! python3 -c 'import qrcode' >/dev/null 2>&1; then
    echo "[!] Python package 'qrcode' is required. Install repository dependencies first." >&2
    exit 1
fi

read -r -p "[+] Enter payload URL or local file path: " PAYLOAD

# Auto-host a local file on the selected LAN source address. This preserves the
# QR-to-another-device workflow without binding the server to every interface.
if [[ -f "$PAYLOAD" ]]; then
    command -v ip >/dev/null 2>&1 || {
        echo "[!] 'ip' is required to determine a LAN address for local-file hosting." >&2
        exit 1
    }

    LOCAL_IP=$(ip route get 1.1.1.1 2>/dev/null | awk '{for (i=1; i<=NF; i++) if ($i == "src") {print $(i+1); exit}}')
    if [[ -z "$LOCAL_IP" ]]; then
        echo "[!] Could not determine a LAN source address. Supply a URL instead." >&2
        exit 1
    fi

    PAYLOAD_BASENAME=$(basename -- "$PAYLOAD")
    cp -- "$PAYLOAD" "$OUTPUT_DIR/$PAYLOAD_BASENAME"

    ENCODED_BASENAME=$(python3 - "$PAYLOAD_BASENAME" <<'PY'
import sys
from urllib.parse import quote
print(quote(sys.argv[1]))
PY
)

    echo "[*] Hosting copied artifact on http://$LOCAL_IP:8080 ..."
    python3 -m http.server 8080 \
        --bind "$LOCAL_IP" \
        --directory "$OUTPUT_DIR" \
        >/dev/null 2>&1 &
    SERVER_PID=$!
    sleep 0.3
    if ! kill -0 "$SERVER_PID" 2>/dev/null; then
        echo "[!] Local HTTP server failed to start." >&2
        exit 1
    fi

    PAYLOAD_URL="http://$LOCAL_IP:8080/$ENCODED_BASENAME"
else
    PAYLOAD_URL="$PAYLOAD"
fi

read -r -p "[?] Shorten URL with is.gd? (y/N): " SHORTEN
if [[ "$SHORTEN" =~ ^[Yy]$ ]]; then
    command -v curl >/dev/null 2>&1 || {
        echo "[!] curl is required for URL shortening." >&2
        exit 1
    }
    SHORTENED=$(curl -fsS --get \
        --data-urlencode "format=simple" \
        --data-urlencode "url=$PAYLOAD_URL" \
        "https://is.gd/create.php")
    echo "[+] Shortened URL: $SHORTENED"
    PAYLOAD_URL="$SHORTENED"
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
QR_PNG="$OUTPUT_DIR/qr_payload_$TIMESTAMP.png"
QR_ASCII="$OUTPUT_DIR/qr_payload_$TIMESTAMP.txt"

echo "[*] Generating QR artifacts..."
python3 - "$PAYLOAD_URL" "$QR_PNG" "$QR_ASCII" <<'PY'
import sys
import qrcode

url, png_path, text_path = sys.argv[1:]
qr = qrcode.QRCode(border=2)
qr.add_data(url)
qr.make(fit=True)
qr.make_image(fill_color="black", back_color="white").save(png_path)

with open(text_path, "w", encoding="utf-8") as handle:
    for row in qr.get_matrix():
        handle.write("".join("██" if cell else "  " for cell in row) + "\n")
PY

echo "[+] QR Code (ASCII):"
cat -- "$QR_ASCII"
echo "[+] PNG saved to: $QR_PNG"
echo "[+] ASCII saved to: $QR_ASCII"
printf '[%s] %s -> %s\n' "$TIMESTAMP" "$PAYLOAD_URL" "$QR_PNG" >> "$OUTPUT_DIR/qr_log.txt"
echo "[*] Log updated: $OUTPUT_DIR/qr_log.txt"

# Optional SSID beacon broadcast. Arguments are passed directly rather than
# constructing a shell command from operator-provided SSID text.
read -r -p "[?] Broadcast fake WiFi SSID? (Linux only, requires airbase-ng) (y/N): " FAKE_SSID
if [[ "$FAKE_SSID" =~ ^[Yy]$ ]]; then
    command -v airbase-ng >/dev/null 2>&1 || {
        echo "[!] airbase-ng is not installed." >&2
        exit 1
    }
    command -v xterm >/dev/null 2>&1 || {
        echo "[!] xterm is required for the interactive beacon window." >&2
        exit 1
    }

    read -r -p "[+] Enter fake SSID name: " SSID
    read -r -p "[+] Monitor-mode interface [wlan0mon]: " MONITOR_IFACE
    MONITOR_IFACE=${MONITOR_IFACE:-wlan0mon}
    echo "[*] Starting beacon with SSID '$SSID' on $MONITOR_IFACE ..."
    xterm -hold -e airbase-ng --essid "$SSID" -c 6 "$MONITOR_IFACE" &
fi

# Cleanup HTTP server, if one was started. Keeping it running is an explicit
# operator choice because the hosted artifact remains reachable on the LAN.
if [[ -n "$SERVER_PID" ]]; then
    read -r -p "[?] Stop local HTTP server now? (Y/n): " STOP_SERVER
    if [[ ! "$STOP_SERVER" =~ ^[Nn]$ ]]; then
        kill "$SERVER_PID" && echo "[*] Server stopped."
    else
        echo "[*] Server left running as PID $SERVER_PID on $LOCAL_IP:8080."
    fi
fi
