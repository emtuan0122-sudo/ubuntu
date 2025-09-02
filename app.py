from http.server import SimpleHTTPRequestHandler, HTTPServer
import os, threading, time

# Job nền: ghi log mỗi 60 giây để biết app đang sống
def worker():
    while True:
        with open("heartbeat.log", "a", encoding="utf-8") as f:
            f.write(f"alive {time.time()}\n")
        time.sleep(60)

threading.Thread(target=worker, daemon=True).start()

# Web server giữ app sống (Railway set PORT, default 8080)
port = int(os.environ.get("PORT", 8080))
HTTPServer(("0.0.0.0", port), SimpleHTTPRequestHandler).serve_forever()
