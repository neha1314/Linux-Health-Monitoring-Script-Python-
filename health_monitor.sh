#!/bin/bash

LOGFILE="health_monitor.log"

CPU_LIMIT=80
MEM_LIMIT=80
DISK_LIMIT=80

echo "$(date): Starting system health monitoring..." >> "$LOGFILE"

while true; do

  # CPU usage
  CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
  CPU_INT=${CPU%.*}

  if [ "$CPU_INT" -gt "$CPU_LIMIT" ]; then
    echo "$(date): High CPU usage: $CPU%" >> "$LOGFILE"
  else
    echo "$(date): CPU usage: $CPU%" >> "$LOGFILE"
  fi

  # Memory usage
  MEM=$(free | awk '/Mem/ {printf("%.0f", $3/$2 * 100)}')
  if [ "$MEM" -gt "$MEM_LIMIT" ]; then
    echo "$(date): High Memory usage: $MEM%" >> "$LOGFILE"
  else
    echo "$(date): Memory usage: $MEM%" >> "$LOGFILE"
  fi

  # Disk usage
  DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
  if [ "$DISK" -gt "$DISK_LIMIT" ]; then
    echo "$(date): High Disk usage: $DISK%" >> "$LOGFILE"
  else
    echo "$(date): Disk usage: $DISK%" >> "$LOGFILE"
  fi

  sleep 10

done
