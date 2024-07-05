#!/bin/bash

# Отримання інформації про доступний простір SSD
ssd_available=$(df -h / | grep '/' | awk '{print $4}')

# Отримання інформації про доступну пам'ять RAM
ram_available=$(free -h | grep Mem | awk '{print $7}')

# Перевірка наявності Go
if go_version=$(go version 2>/dev/null); then
    go_status="встановлено ($go_version)"
else
    go_status="не встановлено"
fi

# Виведення інформації
echo "На вашому сервері доступно:"
echo "SSD доступно: $ssd_available"
echo "RAM доступно: $ram_available"
echo "Мова програмування GO: $go_status"
