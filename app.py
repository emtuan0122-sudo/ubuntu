from http.server import SimpleHTTPRequestHandler, HTTPServer
import os, threading, time

# Job nền: ghi log mỗi 60 giây để biết app đang sống
def worker():
    while True:
        with open("heartbeat.log", "a", encoding="utf-8") as f:
            f.write(f"alive {time.time()}\n")
        time.sleep(60)

threading.Thread(target=worker, daemon=True).start()

# Chọn cổng web: lấy từ $PORT (Railway) hoặc 8080
raw = os.environ.get("PORT", "8080")
try:
    p = int(raw)
    # Phòng nhầm: nếu ai đó set PORT=2222 (trùng SSH) thì tự chuyển 8080
    port = 8080 if p == 2222 else p
except ValueError:
    port = 8080

print(f"[app.py] Serving HTTP on 0.0.0.0:{port}", flush=True)
HTTPServer(("0.0.0.0", port), SimpleHTTPRequestHandler).serve_forever()
