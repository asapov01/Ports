#!/bin/bash

# Оголошення змінних для кольорів
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Без кольору

echo ""
echo -e "${GREEN}Ви побачите результат перевірки приблизно за 1 хвилину:${NC}"

# Перевірка наявності speedtest-cli, встановлення та виконання тесту швидкості інтернету
if ! command -v speedtest-cli &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y speedtest-cli
fi

speed_test=$(speedtest-cli --simple | awk '/Download/ {print "Download: "$2" "$3} /Upload/ {print "Upload: "$2" "$3}')

# Виконання dd і зберігання результату в змінну disk_speed
dd_output=$(dd if=/dev/zero of=testfile bs=1G count=1 oflag=dsync 2>&1)
disk_speed=$(echo "$dd_output" | grep -o '[0-9.]*\s*MB/s')

# Збереження результату в змінну get_disk_speed
get_disk_speed="$disk_speed"

# Видалення тестового файлу
rm -f testfile

# Перевірка версії Ubuntu
ubuntu_version=$(lsb_release -d | awk -F"\t" '{print $2}')

# Отримання інформації про доступний простір SSD/NVME
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

# Отримання інформації про доступну пам'ять RAM
ram_available=$(free -h | grep Mem | awk '{print $7}')

# Перевірка кількості ядер CPU на сервері
cpu_available=$(nproc)

# Отримання архітектури процесора
cpu_type=$(uname -m)

# Перегляд зайнятих портів
occupied_ports=$(ss -tulnp | grep 'LISTEN')

# Перегляд активних процесів
active_process=$(systemctl list-units --type=service --state=running)

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

# Перевірка наявності .bash_profile та створення, якщо потрібно
bash_profile="$HOME/.bash_profile"
if [ ! -f "$bash_profile" ]; then
    touch "$bash_profile"
fi

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
echo -e "${GREEN}Швидкість запису диску: ${RED}$get_disk_speed${NC}"
echo ""
echo -e "${GREEN}Зайняті порти:${NC}"
echo -e "${occupied_ports}"
echo ""
echo -e "${GREEN}Активні процеси:${NC}"
echo -e "${active_process}"
