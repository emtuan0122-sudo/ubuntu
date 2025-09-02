#!/usr/bin/env bash
set -euo pipefail

# Chuẩn bị sshd
mkdir -p /var/run/sshd /var/log/ssh
ssh-keygen -A

echo "[entrypoint] PORT=${PORT:-unset}"

# Chạy SSHD nền (cổng 2222)
# root đăng nhập bị tắt; user là 'ubuntu'
/usr/sbin/sshd -D -p 2222 &

# Chạy web server – lắng nghe $PORT (nếu không có thì 8080)
export PORT="${PORT:-8080}"
exec python3 /app/app.py
