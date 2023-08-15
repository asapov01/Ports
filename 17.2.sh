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

function is_port_taken {
    local port=$1
    if ss -tuln | awk -v p=":${port} " '$0 ~ p {exit 1}'; then
        return 0
    else
        return 1
    fi
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
            printGreen "У стовпці Local Adress:Port ви бачите порти які вже використовуються на вашому сервері."
            printRed "Наприклад: 127.0.0.1:28657 - використовується порт 28657"
            printRed "Наприклад: *:9090 - використовується порт 9090"
            printRed " 0.0.0.0:8080 - використовується порт 8080"
            ss -tuln
        elif [[ $choice == "2" ]]; then
            clear
            logo
            printGreen "Перелік нод з панелі та стандартних портів які використовує кожна з них:"
            echo -n "Shardeum: "
            if is_port_taken 8080 || is_port_taken 9001; then
                echo -e "\e[1m\e[31m8080,9001\e[0m"
            else
                echo "8080,9001"
            fi
            echo -n "StarkNet: "
            if is_port_taken 9545; then
                echo -e "\e[1m\e[31m9545\e[0m"
            else
                echo "9545"
            fi
            echo -n "Meson: "
            if is_port_taken 443; then
                echo -e "\e[1m\e[31m443\e[0m"
            else
                echo "443"
            fi
            echo -n "Subspace: "
            if is_port_taken 30333; then
                echo -e "\e[1m\e[31m30333\e[0m"
            else
                echo "30333"
            fi
            echo -n "Lava: "
            if is_port_taken 9090 || is_port_taken 9091 || is_port_taken 26658 || is_port_taken 26657 || is_port_taken 26656 || is_port_taken 6060 || is_port_taken 26660 || is_port_taken 1317; then
                echo -e "\e[1m\e[31m9090,9091,26658,26657,26656,6060,26660,1317\e[0m"
            else
                echo "9090,9091,26658,26657,26656,6060,26660,1317"
            fi
            echo -n "Nibiru: "
            if is_port_taken 9090 || is_port_taken 9091 || is_port_taken 26658 || is_port_taken 26657 || is_port_taken 26656 || is_port_taken 6060 || is_port_taken 26660 || is_port_taken 1317; then
                echo -e "\e[1m\e[31m9090,9091,26658,26657,26656,6060,26660,1317\e[0m"
            else
                echo "9090,9091,26658,26657,26656,6060,26660,1317"
            fi
            echo -n "DeFund: "
            if is_port_taken 9090 || is_port_taken 9091 || is_port_taken 26658 || is_port_taken 26657 || is_port_taken 26656 || is_port_taken 6060 || is_port_taken 26660 || is_port_taken 1317; then
                echo -e "\e[1m\e[31m9090,9091,26658,26657,26656,6060,26660,1317\e[0m"
            else
                echo "9090,9091,26658,26657,26656,6060,26660,1317"
            fi
            printGreen "Перелік портів мережі Cosmos,які пропонуються вам при початку встановлення"
            echo -n "2  - 9190, 9191, 27658, 27657, 27656, 6160, 27660, 1417"
            if is_port_taken 9190 || is_port_taken 9191 || is_port_taken 27658 || is_port_taken 27657 || is_port_taken 27656 || is_port_taken 6160 || is_port_taken 27660 || is_port_taken 1417; then
                echo -e "\e[1m\e[31m9190,9191,27658,27657,27656,6160,27660,1417\e[0m"
            else
                echo "2  - 9190, 9191, 27658, 27657, 27656, 6160, 27660, 1417"
            fi

            echo "Lava, DeFund, Nibiru використовують одні і ті ж самі порти, тому при встановленні з запропонованого списку вибирайте різний набір портів"
            echo "Перед встановленням будь-якої ноди, перевіряйте чи зайняті порти які буде використовувати ця нода, через цю панель."
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
