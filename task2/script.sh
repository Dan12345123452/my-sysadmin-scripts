#!/bin/bash

INTERVAL=10
LOG_FILE="monitor.log"

echo "Мониторинг запущен. Интервал: ${INTERVAL} секунд."
echo "Результаты записываются в: ${LOG_FILE}"
echo "Остановка: Ctrl+C"

while true; do
    {
        echo "========================================"
        echo "Дата и время: $(date)"
        echo ""
        echo "--- Память ---"
        free -h
        echo ""
        echo "--- Диск ---"
        df -h /
        echo ""
        echo "--- Нагрузка системы ---"
        uptime
        echo ""
    } >> "$LOG_FILE"

    sleep "$INTERVAL"
done
