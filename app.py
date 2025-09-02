from http.server import SimpleHTTPRequestHandler, HTTPServer
import os, threading, time, subprocess

# (Tuỳ chọn) việc bạn muốn chạy nền 24/7 bỏ vào đây
def worker():
    while True:
        # ví dụ: ghi log mỗi 60 giây
        with open("heartbeat.log", "a", encoding="utf-8") as f:
            f.write(f"alive {time.time()}\n")
        time.sleep(60)

threading.Thread(target=worker, daemon=True).start()

# web server giữ app "sống"
port = int(os.environ.get("PORT", 8080))
HTTPServer(("0.0.0.0", port), SimpleHTTPRequestHandler).serve_forever()
