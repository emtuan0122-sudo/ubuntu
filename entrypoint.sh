#!/usr/bin/env bash
set -euo pipefail

# Chuẩn bị sshd
mkdir -p /var/run/sshd /var/log/ssh
ssh-keygen -A

# In ra PORT hiện tại để kiểm tra
echo "[entrypoint] PORT=\${PORT:-unset}"

# Chạy SSHD nền trên cổng 2222
/usr/sbin/sshd -D -p 2222 &

# Chạy web server – lắng nghe PORT (nếu Railway set), mặc định 8080
export PORT="${PORT:-8080}"
exec python3 /app/app.py
