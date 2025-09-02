FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Cài OpenSSH + Python3
RUN apt-get update && \
    apt-get install -y openssh-server python3 ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo user đăng nhập SSH (đổi mật khẩu ngay!)
RUN useradd -m ubuntu && echo 'ubuntu:ChangeMe_123' | chpasswd

# Bật PasswordAuthentication & dùng cổng 2222 cho SSH
RUN sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?Port .*/Port 2222/' /etc/ssh/sshd_config

WORKDIR /app
COPY app.py /app/app.py
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# HTTP: 8080 (web), SSH: 2222
EXPOSE 8080 2222

CMD ["/app/entrypoint.sh"]
