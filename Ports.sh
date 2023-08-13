#!/bin/bash

function logo() {
    bash <(curl -s https://raw.githubusercontent.com/CPITMschool/Scripts/main/logo.sh)
}

function printGreen {
    echo -e "\e[1m\e[32m${1}\e[0m"
}

function check {
    while true; do
        printGreen "Нода DeFund"
        printGreen "Виберіть, що ви хочете переглянути:"
        echo "1) Переглянути зайняті порти."
        echo "2) Вийти."
        read choice

        if [[ $choice == "1" ]]; then
            printGreen "В 3 стовбці ви бачите перелік зайнятих портів на вашому сервері."
            printGreen "Наприклад::::30333 -використовується порт 30333"
            printGreen "Наприклад::::9090 - використовується порт 9090"
            printGreen "127.0.0.1:26657 - використовується порт 26657"
            netstat -tuln
        elif [[ $choice == "2" ]]; then
            break
        else
            echo "Невірний вибір."
        fi
    done
}

clear
logo
check
