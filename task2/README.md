# Задание 2 — Контейнер, RAID1/LVM и reverse proxy с TLS

## 1. Docker-контейнер и том

Создан Docker-образ `sysadmin-monitor:1.0` на основе Ubuntu 22.04. Контейнер запускает скрипт мониторинга системы, а результаты записывает в `monitor.log` в Docker-том `monitor-data`.

Проверки:
- `sudo docker ps -a`
- `sudo docker volume ls`
- `sudo docker exec sysadmin-monitor tail -n 10 /app/monitor.log`

## 2. RAID1 и LVM

Для лабораторной работы созданы два тестовых файла по 256 МБ, подключённые как loop-устройства. На них создан RAID1-массив `/dev/md0`.

На массиве настроен LVM:
- PV: `/dev/md0`
- VG: `vg_sysadmin`
- LV: `lv_data`
- Файловая система: `ext4`
- Точка монтирования: `/mnt/sysadmin-lvm`

Создан тестовый файл `/mnt/sysadmin-lvm/test.txt`.

Результаты проверок сохранены в `evidence/raid-lvm-checks.txt`.

## 3. Nginx reverse proxy с TLS

Nginx принимает HTTPS-запросы на порту 443 и пересылает их backend-сервису на `127.0.0.1:8080`.

Используется самоподписанный сертификат для локальной учебной проверки. Закрытый ключ хранится вне репозитория в `/etc/nginx/ssl/sysadmin.key` и не включается в Git.

Конфигурация: `configs/nginx/sysadmin-proxy`.

Проверки:
- `sudo nginx -t`
- `sudo systemctl status nginx --no-pager`
- `curl -k https://localhost`

Ожидаемый ответ: `Sysadmin project: backend works!`

## 4. Сервис systemd

Сервис `sysadmin-backend.service` запускает Python HTTP-сервер на `127.0.0.1:8080` и включён в автозапуск.

Конфигурация: `configs/systemd/sysadmin-backend.service`.

Проверки:
- `sudo systemctl status sysadmin-backend --no-pager`
- `systemctl is-active sysadmin-backend`
- `curl http://127.0.0.1:8080`

## 5. Файлы доказательств

- `evidence/raid-lvm-checks.txt` — состояние RAID1, LVM и тестового файла.
- `evidence/service-checks.txt` — проверки Docker, HTTPS и systemd.

## Примечание

RAID1 использует тестовые файлы и loop-устройства, поэтому это демонстрационная конфигурация для лабораторной работы, а не отказоустойчивая система хранения для production.
