#!/bin/bash

# Перевірка наявності speedtest-cli, встановлення та виконання тесту швидкості інтернету
if ! command -v speedtest-cli &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y speedtest-cli
fi

# Функція для виведення швидкості запису диску
function get_disk_speed {
    dd_output=$(dd if=/dev/zero of=testfile bs=1G count=1 oflag=dsync 2>&1)
    disk_speed=$(echo "$dd_output" | grep -o '[0-9.]*\s*MB/s')
    echo "$disk_speed"
    rm -f testfile
}

# Збір інформації про сервер
ubuntu_version=$(lsb_release -d | awk -F"\t" '{print $2}')

if lsblk | grep -q "nvme"; then
    ssd_type="NVME"
    ssd_available=$(df -h / | grep '/' | awk '{print $4}')
elif lsblk | grep -q "sda"; then
    ssd_type="SSD"
    ssd_available=$(df -h / | grep '/' | awk '{print $4}')
else
    ssd_type="Невідомий тип"
    ssd_available="Невідомий обсяг"
fi

ram_available=$(free -h | grep Mem | awk '{print $7}')
cpu_available=$(nproc)
cpu_type=$(uname -m)
occupied_ports=$(ss -tulnp | grep 'LISTEN')

if go_version=$(go version 2>/dev/null); then
    go_status="встановлено ($go_version)"
else
    go_status="не встановлено"
fi

if screen -version &> /dev/null; then
    screen_status="встановлено"
else
    screen_status="не встановлено"
fi

if docker_version=$(docker --version 2>/dev/null); then
    docker_status="встановлено ($docker_version)"
else
    docker_status="не встановлено"
fi

bash_profile="$HOME/.bash_profile"
if [ ! -f "$bash_profile" ]; then
    touch "$bash_profile"
fi

# Кольори
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Без кольору

# Виведення інформації
echo ""
echo -e "${GREEN}На вашому сервері доступно:${NC}"
echo ""
echo -e "${GREEN}Ubuntu: ${RED}$ubuntu_version${NC}"
echo -e "${GREEN}Тип диска: ${RED}$ssd_type${NC}"
echo -e "${GREEN}SSD/NVME доступно: ${RED}$ssd_available${NC}"
echo -e "${GREEN}RAM доступно: ${RED}$ram_available${NC}"
echo -e "${GREEN}CPU ядер на сервері: ${RED}$cpu_available${NC}"
echo -e "${GREEN}Архітектура процесора: ${RED}$cpu_type${NC}"
echo -e "${GREEN}Мова програмування GO: ${RED}$go_status${NC}"
echo -e "${GREEN}Утиліта screen: ${RED}$screen_status${NC}"
echo -e "${GREEN}Docker: ${RED}$docker_status${NC}"
echo -e "${GREEN}Швидкість інтернету: ${RED}$speed_test${NC}"
echo -e "${GREEN}Швидкість запису диску: ${RED}$(get_disk_speed)${NC}"
echo -e "${GREEN}Зайняті порти:${NC}"
echo -e "${occupied_ports}"
