#!/bin/bash

function logo() {
    bash <(curl -s https://raw.githubusercontent.com/CPITMschool/Scripts/main/logo.sh)
}

function printGreen {
    echo -e "\e[1m\e[32m${1}\e[0m"
}

function printRed {
  echo -e "\e[1m\e[31m${1}\e[0m"
}

function check {
    while true; do
        printGreen "Виберіть, що ви хочете переглянути:"
        echo "1) Переглянути зайняті порти."
        echo "2) Перегляти перелік нод панелі та портів які вони використовують"
        echo "3) Вийти."
        read choice

        if [[ $choice == "1" ]]; then
            clear
            logo
            printGreen "У третьому стовпці ви побачите список портів, які вже використовуються на вашому сервері."
            printRed "Наприклад::::30333 -використовується порт 30333"
            printRed "Наприклад::::9090 - використовується порт 9090"
            printRed "Наприклад 127.0.0.1:26657 - використовується порт 26657"
            netstat -tuln
        elif [[ $choice == "2" ]]; then
            clear
            logo
            printGreen "Перелік нод з панелі та стандартних портів які використовує кожна з них:"
            echo "Shardeum: 8080,9001"
            echo "StarkNet: 9545"
            echo "Meson: 443"
            echo "Subspace: 30333"
            echo "Lava: 9090, 9091, 26658, 26657, 26656, 6060, 26660, 1317"
            echo "Nibiru: 9090, 9091, 26658, 26657, 26656, 6060, 26660, 1317"
            echo "DeFund: 9090, 9091, 26658, 26657, 26656, 6060, 26660, 1317"
            echo "Gear: 30333"
            echo ""
            printRed "Gear через панель працює на порті 31333,для уникнення конфлікту з нодою Subspace яка у вас може бути встановлена раніше."
            printRed "Lava,DeFund,Nibiru використовують одні і ті ж самі порти, тому при встановлені з запропонованого списку вибирайте різний набір портів."
            printRed "Перед встановленням будь-якої ноди, перевіряйте чи зайняті порти які буде використовувати ця нода, через цю панель."
        elif [[ $choice == "3" ]]; then
            break
        else
            echo "Невірний вибір."
        fi
    done
}

clear
logo
check
