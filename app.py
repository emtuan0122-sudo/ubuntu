from http.server import SimpleHTTPRequestHandler, HTTPServer
import os, threading, time, sys

def worker():
    while True:
        with open("heartbeat.log", "a", encoding="utf-8") as f:
            f.write(f"alive {time.time()}\n")
        time.sleep(60)

threading.Thread(target=worker, daemon=True).start()

env_port = os.environ.get("PORT", "")
port = 8080
try:
    if env_port:
        p = int(env_port)
        # tránh đụng cổng SSH
        port = 8080 if p == 2222 else p
except ValueError:
    port = 8080

print(f"[app.py] Serving HTTP on 0.0.0.0:{port}", flush=True)
HTTPServer(("0.0.0.0", port), SimpleHTTPRequestHandler).serve_forever()
