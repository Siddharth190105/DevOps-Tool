#!/bin/bash

# Load config
source ./config.sh

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

echo "[$(date)] Starting backup process..." >> $LOG_FILE

# Create backup
tar -czf $BACKUP_FILE $SOURCE_DIR

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup created: $BACKUP_FILE" >> $LOG_FILE
else
    echo "[$(date)] Backup failed!" >> $LOG_FILE
fi

# Cleanup old backups
echo "[$(date)] Cleaning files older than $RETENTION_DAYS days..." >> $LOG_FILE

find $BACKUP_DIR -type f -mtime +$RETENTION_DAYS -exec rm {} \;

echo "[$(date)] Cleanup completed." >> $LOG_FILE
