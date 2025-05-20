#!/bin/bash

echo "[*] Starting PulseAudio..."
mkdir -p /run/pulse
pulseaudio --start

echo "[*] Starting SSH..."
service ssh start

echo "[*] Starting Docker..."
dockerd &

echo "[*] Starting D-Bus..."
service dbus start

echo "[*] Starting XRDP..."
service xrdp restart

echo "[*] Starting VNC server for root..."
vncserver :1 -geometry 1280x800 -depth 24

echo "[*] Starting noVNC on port 8080..."
/opt/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 8080 &

echo "✅ System ready"
echo "➡️  RDP on port 3389"
echo "➡️  noVNC on http://localhost:8080"
echo "➡️  SSH on port 22 (user: root, password: root)"

tail -f /var/log/xrdp-sesman.log
