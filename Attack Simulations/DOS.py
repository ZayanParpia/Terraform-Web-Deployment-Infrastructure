import time
import requests

url = input("LINK: ").strip()
total = int(input("How many requests?: "))

allowed = 0
blocked = 0
errors = 0

for i in range(1, total + 1):
    try:
        r = requests.get(url, timeout=5)
        if r.status_code == 403:
            blocked += 1
        else:
            allowed += 1
        print(f"[{i}/{total}] status {r.status_code} | allowed: {allowed} | blocked: {blocked}")
    except requests.RequestException as e:
        errors += 1
        print(f"[{i}/{total}] error: {e}")
