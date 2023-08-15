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
            printGreen "Перелік нод з панелі та стандартних портів які використовує кожна з них."
            printGreen "Якщо порт відображається червоним - він зайнятий на вашому сервері, білим - вільний"
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
            echo -n "2  - "
            if is_port_taken 9190 || is_port_taken 9191 || is_port_taken 27658 || is_port_taken 27657 || is_port_taken 27656 || is_port_taken 6160 || is_port_taken 27660 || is_port_taken 1417; then
                echo -e "\e[1m\e[31m9190,9191,27658,27657,27656,6160,27660,1417\e[0m"
            else
                echo "9190, 9191, 27658, 27657, 27656, 6160, 27660, 1417"
            fi
            echo -n "3  - "
            if is_port_taken 9290 || is_port_taken 9291 || is_port_taken 28658 || is_port_taken 28657 || is_port_taken 28656 || is_port_taken 6260 || is_port_taken 28660 || is_port_taken 1517; then
                echo -e "\e[1m\e[31m9290,9291,28658,28657,28656,6260,28660,1517\e[0m"
            else
                echo "9290, 9291, 28658, 28657, 28656, 6260, 28660, 1517"
            fi

            echo -n "4  - "
            if is_port_taken 9390 || is_port_taken 9391 || is_port_taken 29658 || is_port_taken 29657 || is_port_taken 29656 || is_port_taken 6360 || is_port_taken 29660 || is_port_taken 1617; then
                echo -e "\e[1m\e[31m9390,9391,29658,29657,29656,6360,29660,1617\e[0m"
            else
                echo "9390, 9391, 29658, 29657, 29656, 6360, 29660, 1617"
            fi

            echo -n "5  - "
            if is_port_taken 9490 || is_port_taken 9491 || is_port_taken 30658 || is_port_taken 30657 || is_port_taken 30656 || is_port_taken 6460 || is_port_taken 30660 || is_port_taken 1717; then
                echo -e "\e[1m\e[31m9490,9491,30658,30657,30656,6460,30660,1717\e[0m"
            else
                echo "9490, 9491, 30658, 30657, 30656, 6460, 30660, 1717"
            fi

            echo -n "6  - "
            if is_port_taken 9590 || is_port_taken 9591 || is_port_taken 31658 || is_port_taken 31657 || is_port_taken 31656 || is_port_taken 6560 || is_port_taken 31660 || is_port_taken 1817; then
                echo -e "\e[1m\e[31m9590,9591,31658,31657,31656,6560,31660,1817\e[0m"
            else
                echo "9590, 9591, 31658, 31657, 31656, 6560, 31660, 1817"
            fi

            echo -n "7  - "
            if is_port_taken 9690 || is_port_taken 9691 || is_port_taken 32658 || is_port_taken 32657 || is_port_taken 32656 || is_port_taken 6660 || is_port_taken 32660 || is_port_taken 1917; then
                echo -e "\e[1m\e[31m9690,9691,32658,32657,32656,6660,32660,1917\e[0m"
            else
                echo "9690, 9691, 32658, 32657, 32656, 6660, 32660, 1917"
            fi

            echo -n "8 - "
            if is_port_taken 9790 || is_port_taken 9791 || is_port_taken 33658 || is_port_taken 33657 || is_port_taken 33656 || is_port_taken 6760 || is_port_taken 33660 || is_port_taken 2017; then
                echo -e "\e[1m\e[31m9790,9791,33658,33657,33656,6760,33660,2017\e[0m"
            else
                echo "9790, 9791, 33658, 33657, 33656, 6760, 33660, 2017"
            fi

            echo -n "9 - "
            if is_port_taken 9890 || is_port_taken 9891 || is_port_taken 34658 || is_port_taken 34657 || is_port_taken 34656 || is_port_taken 6860 || is_port_taken 34660 || is_port_taken 2117; then
                echo -e "\e[1m\e[31m9890,9891,34658,34657,34656,6860,34660,2117\e[0m"
            else
                echo "9890, 9891, 34658, 34657, 34656, 6860, 34660, 2117"
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
