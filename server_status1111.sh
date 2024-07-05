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

# Перевірка наявності screen
if screen -version &> /dev/null; then
    screen_status="встановлено"
else
    screen_status="не встановлено"
fi

# Перевірка наявності Docker
if docker_version=$(docker --version 2>/dev/null); then
    docker_status="встановлено ($docker_version)"
else
    docker_status="не встановлено"
fi

# Кольори
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Без кольору

# Виведення інформації
echo ""
echo -e "${GREEN}На вашому сервері доступно:${NC}"
echo ""
echo -e "${GREEN}SSD доступно: ${RED}$ssd_available${NC}"
echo -e "${GREEN}RAM доступно: ${RED}$ram_available${NC}"
echo -e "${GREEN}Мова програмування GO: ${RED}$go_status${NC}"
echo -e "${GREEN}Утиліта screen: ${RED}$screen_status${NC}"
echo -e "${GREEN}Docker: ${RED}$docker_status${NC}"
