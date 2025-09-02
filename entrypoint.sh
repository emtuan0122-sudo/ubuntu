#!/usr/bin/env bash
set -e

# Start SSHD (cổng 2222) chạy nền
mkdir -p /var/run/sshd
/usr/sbin/sshd -D -p 2222 &

# Chạy web server (giữ app sống) – app.py lắng nghe PORT=8080
python3 /app/app.py
