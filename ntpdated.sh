#!/bin/bash
# ntpdated — Однократная синхронизация времени в фоне

# Параметры
#SERVER="pool.ntp.org"
SERVER="162.159.200.1" # Используем IP (Cloudflare NTP), чтобы не зависеть от DNS
LOG_FILE="/var/log/ntpdated.log"
INTERVAL=10

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "Служба запущена, ожидание сети..."

while true; do
    if ntpdate -u "$SERVER" > /dev/null 2>&1; then
        log "Успех: Время синхронизировано."
        
        # Сохраняем в аппаратные часы (BIOS) 
        if hwclock --systohc; then # Если время нужно в utc то использовать команду: hwclock --systohc --utc
            log "BIOS обновлен. Завершение работы."
        fi
        
        exit 0
    fi
    
    sleep $INTERVAL
done
