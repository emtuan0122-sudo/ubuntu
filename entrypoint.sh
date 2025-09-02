#!/usr/bin/env bash
set -euo pipefail

# Chuẩn bị sshd
mkdir -p /var/run/sshd /var/log/ssh
ssh-keygen -A

# Chạy SSHD nền trên cổng 2222
/usr/sbin/sshd -D -p 2222 &

# Chạy web server (app.py) – lắng nghe PORT (mặc định 8080)
exec python3 /app/app.py
