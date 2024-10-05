#! /bin/bash
# JN Hernández
# Oct 4, 2024
# Use: BASH script for monitoring the root directory disk usage on a server

RECIPIENT="monitoring-team@company.com"
SUBJECT="Root Directory Disk Usage Exceeded 80%"

DISK_USAGE=$(df -h / | awk 'FNR == 2 { print $5 }' | cut -f1 -d"%")
#DISK_USAGE=$(df -h /dev | awk 'FNR == 2 { print $5 }' | cut -f1 -d"%") #test for 100%

if [ $((DISK_USAGE)) -gt 80 ]; then
    echo "$(date): Warning: Root directory disk usage has exceeded 80% - please investigate \
as soon as possible." >> disk_usage.log
    echo "$(date): Disk usage is at $DISK_USAGE%" >> disk_usage.log
    tail -2 disk_usage.log | mailx -s "$SUBJECT" "$RECIPIENT"
fi
