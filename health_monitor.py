import psutil
import time
from datetime import datetime

# Threshold values
CPU_LIMIT = 80
MEM_LIMIT = 80
DISK_LIMIT = 80

# Log function
def log(message):
    with open("health_monitor.log", "a") as f:
        f.write(f"[{datetime.now()}] {message}\n")
    print(f"[{datetime.now()}] {message}")

# Check CPU usage
def check_cpu():
    cpu = psutil.cpu_percent(interval=1)
    if cpu > CPU_LIMIT:
        log(f"High CPU usage: {cpu}%")
    else:
        log(f"CPU usage: {cpu}%")

# Check memory usage
def check_memory():
    mem = psutil.virtual_memory().percent
    if mem > MEM_LIMIT:
        log(f"High Memory usage: {mem}%")
    else:
        log(f"Memory usage: {mem}%")

# Check disk usage
def check_disk():
    disk = psutil.disk_usage('/').percent
    if disk > DISK_LIMIT:
        log(f"High Disk usage: {disk}%")
    else:
        log(f"Disk usage: {disk}%")

# Main loop
def monitor():
    log("Starting system health monitoring...")
    while True:
        check_cpu()
        check_memory()
        check_disk()
        time.sleep(10)

if __name__ == "__main__":
    monitor()
