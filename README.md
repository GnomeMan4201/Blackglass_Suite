# BLACKGLASS

<p align="center">
  <img src="assets/blackglass_demo.png" alt="BLACKGLASS Demo" width="700">
</p>

**BLACKGLASS:** Offline payload scoring, autonomous QR/ZIP flyer creation, and stealth beacon monitoring in Termux and Linux.

---

## Features at a Glance

- **Master automation:** Scoring, flyer generation, QR, ZIP export  
- **AI-driven payload mutation:** Unique, original, and obfuscated payload creation  
- **HTML flyer & QR generation:** Shareable, stealthy delivery mechanisms  
- **Live beacon monitoring:** See hits in real time, even offline  
- **Fully local/offline:** Works in Termux, Linux, and headless deployments  
- **AI scoring with Llama.cpp:** All payloads scored locally, never sent to the cloud  

---
---

## Command Overview

| Script/Module            | Description                                    |
|--------------------------|------------------------------------------------|
| `blackglass_forge.py`    | Master automation: scoring, flyers, QR, ZIP    |
| `mutate_payload.py`      | AI-driven payload mutation engine              |
| `qr_flyer_builder.py`    | HTML flyer & QR code generator                 |
| `zip_exporter.py`        | Auto-package bundles for delivery              |
| `beacon_server.py`       | Local stealth beacon monitoring                |
| `score_payload.py`       | Offline payload scoring (llama.cpp)            |
| `dashboard.py`           | Dashboard for all payloads/reports             |
| `blackglass_demo.sh`     | Launch demo                                    |

---

## Screenshots

<p align="center">
  <img src="assets/blackglass_demo.png" alt="BLACKGLASS Demo" width="700">
</p>
<p align="center"><i>BLACKGLASS: Dashboard, AI scoring, and beacon logs in Termux</i></p>

---

## Quick Start

```bash
git clone https://github.com/GnomeMan4201/BLACKGLASS_Suite.git
cd BLACKGLASS_Suite
pip install -r requirements.txt
python3 blackglass_forge.py
