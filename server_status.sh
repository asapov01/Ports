#!/bin/bash

# Отримання інформації про доступний простір SSD
ssd_available=$(df -h / | grep '/' | awk '{print $4}')

# Отримання інформації про доступну пам'ять RAM
ram_available=$(free -h | grep Mem | awk '{print $7}')

# Отримання інформації про використання CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

# Виведення інформації
echo "На вашому сервері доступно:"
echo "SSD: $ssd_available"
echo "RAM: $ram_available"
echo "CPU: $cpu_usage"
