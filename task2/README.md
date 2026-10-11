# Задание 2 — Docker и системное администрирование

## 1. Docker-контейнер и том

Создан Docker-образ `sysadmin-monitor:1.0` на основе Ubuntu 22.04.

Контейнер запускает скрипт мониторинга системы `script.sh`. Данные записываются в файл `monitor.log` в подключённом Docker-томе `monitor-data`.

### Сборка образа

```bash
sudo docker build -t sysadmin-monitor:1.0 .
```

### Запуск через Docker Compose

```bash
sudo docker compose up -d
```

### Проверка контейнера

```bash
sudo docker compose ps
```

### Проверка журнала

```bash
sudo docker exec sysadmin-monitor tail -n 10 /app/monitor.log
```

### Проверка подключённого тома

```bash
sudo docker volume inspect monitor-data
```

## 2. Дополнительные части задания

- RAID1 и LVM на тестовых loop-устройствах.
- Nginx reverse proxy с TLS.
- Системный сервис systemd.
- Скриншоты и результаты проверок.

*Статус: работа выполняется. Результаты дополнительных частей будут добавлены после настройки и проверки.*
