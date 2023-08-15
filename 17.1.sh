echo -n "2  - 9190, 9191, 27658, 27657, 27656, 6160, 27660, 1417"
            if is_port_taken 9190 || is_port_taken 9191 || is_port_taken 27658 || is_port_taken 27657 || is_port_taken 27656 || is_port_taken 6160 || is_port_taken 27660 || is_port_taken 1417; then
                echo -e "\e[1m\e[31m9190,9191,27658,27657,27656,6160,27660,1417\e[0m"
            else
                echo "2  - 9190, 9191, 27658, 27657, 27656, 6160, 27660, 1417"
            fi
