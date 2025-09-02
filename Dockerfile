FROM python:3.12-slim
ENV DEBIAN_FRONTEND=noninteractive

# Gói cần thiết: SSHD, sudo (để bạn apt qua SSH), curl, git, ca-certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server sudo curl git ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo user 'ubuntu' (có sudo) và tắt root login qua SSH
RUN useradd -m -s /bin/bash ubuntu \
 && echo 'ubuntu:ChangeMe_123' | chpasswd \
 && adduser ubuntu sudo \
 && sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

# Cấu hình SSH: bật password auth, cổng 2222
RUN sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
 && sed -i 's/^#\?Port .*/Port 2222/' /etc/ssh/sshd_config

WORKDIR /app
COPY app.py /app/app.py
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Web: 8080 | SSH: 2222
EXPOSE 8080 2222

CMD ["/app/entrypoint.sh"]
