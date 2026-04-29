#!/bin/bash

# =========================
# Threshold Configuration
# =========================
CPU_THRESHOLD=80
RAM_THRESHOLD=80
STORAGE_THRESHOLD=80

# =========================
# Email Configuration
# =========================
EMAIL_ID="YOUR-EMAIL-ID"
APP_PASSWORD="YOUR-APP-PASSWORD"

# =========================
# Process & Port Monitoring
# =========================
PROCESS_NAME="nginx"   # Change process name if needed
PORT=80                # Change port if needed

echo "CPU, RAM, Storage, Process and Port Monitoring"
echo "Current Date and Time: $(date)"

# =========================
# Email Sending Function
# =========================
send_email() {
    SUBJECT="$1"
    BODY="$2"

    curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
      --mail-from "$EMAIL_ID" \
      --mail-rcpt "$EMAIL_ID" \
      --user "$EMAIL_ID:$APP_PASSWORD" \
      -T <(echo -e "From: $EMAIL_ID\nTo: $EMAIL_ID\nSubject: $SUBJECT\n\n$BODY")
}

# =========================
# CPU Monitoring
# =========================
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
CPU_USAGE_INT=${CPU_USAGE%.*}

if [ "$CPU_USAGE_INT" -gt "$CPU_THRESHOLD" ]; then
    send_email "CPU Usage Alert" \
    "CPU usage exceeded $CPU_THRESHOLD%.
Current Usage: $CPU_USAGE_INT%"
fi

# =========================
# RAM Monitoring
# =========================
RAM_USAGE=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
RAM_USAGE_INT=${RAM_USAGE%.*}

if [ "$RAM_USAGE_INT" -gt "$RAM_THRESHOLD" ]; then
    send_email "RAM Usage Alert" \
    "RAM usage exceeded $RAM_THRESHOLD%.
Current Usage: $RAM_USAGE_INT%"
fi

# =========================
# Storage Monitoring
# =========================
STORAGE_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
STORAGE_USAGE_INT=${STORAGE_USAGE%.*}

if [ "$STORAGE_USAGE_INT" -gt "$STORAGE_THRESHOLD" ]; then
    send_email "Storage Usage Alert" \
    "Storage usage exceeded $STORAGE_THRESHOLD%.
Current Usage: $STORAGE_USAGE_INT%"
fi

# =========================
# Process Monitoring
# =========================
if ! pgrep -x "$PROCESS_NAME" > /dev/null; then
    send_email "Process Down Alert" \
    "The process '$PROCESS_NAME' is NOT running on the system."
fi

# =========================
# Port Monitoring
# =========================
PORT=80

if ! sudo netstat -tulpn | grep -q ":$PORT "; then
    send_email "Port Down Alert" \
    "ERROR: Port $PORT is NOT listening on the system.

Host: $(hostname)
Time: $(date)"
fi


echo "Monitoring completed successfully."


