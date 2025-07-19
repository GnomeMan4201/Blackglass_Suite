<p align="center">
  <!-- Add your banner here later -->
  <!-- <img src="assets/blackglass_banner.png" alt="BLACKGLASS Banner" width="600"> -->
</p>

# BLACKGLASS

The next-gen, AI-powered payload intelligence & adversary simulation suite for red teams, blue teams, and automation-focused hackers.

---

## Features at a Glance

- **Offline AI scoring, tagging, and stealth recommendations**
- **Automated payload mutation, packaging, and report generation**
- **Stealth beacon monitoring, QR code flyers, ZIP delivery**
- **Kali, Linux, and Termux support**

---

## Command Overview

| Script/Module             | Description                                |
|---------------------------|--------------------------------------------|
| `blackglass_forge.py`     | Master automation: scoring, flyers, QR, ZIP|
| `mutate_payload.py`       | AI-driven payload mutation engine          |
| `qr_flyer_builder.py`     | HTML flyer & QR generation                 |
| `zip_exporter.py`         | Auto-package bundles for delivery          |
| `beacon_server.py`        | Local stealth beacon monitoring            |
| `score_payload.py`        | Offline payload scoring (llama.cpp)        |
| `dashboard.py`            | Dashboard for all payloads/reports         |
| `blackglass_demo.sh`      | Launch demo                                |

---

## Screenshots

<p align="center">
  <img src="assets/blackglass_demo.png" alt="BLACKGLASS in action" width="700">
</p>
<p align="center"><i>BLACKGLASS: Dashboard, AI scoring, and beacon logs in Termux</i></p>

---

## Quick Start

```bash
git clone https://github.com/GnomeMan4201/BLACKGLASS_Suite.git
cd BLACKGLASS_Suite
pip install -r requirements.txt
python3 blackglass_forge.py
