#!/bin/bash

architecture=$(uname -a  | awk '{print $1 " " $2 " "  $3 " "  $4 " " $5 " " $7 " " $8 " " $9 " " $10 " " $11}')
cpu=$(lscpu |grep "^CPU(s):" | awk '{print $2}')
vcpu=$(lscpu |grep "^Thread(s) per core:" | awk '{print $4}')
used_rm=$(free -m | grep "Mem" | awk '{print $3}')
total_rm=$(free -m | grep "Mem" | awk '{print $2}')
used_by_precentage=$(free -m | grep "Mem" | awk '{printf("%.2f", ($3/$2)*100)}')
Diskused=$(df -H --total | grep "total" | awk  '{print $3}')
Disktotal=$(df -H --total | grep "total" | awk '{print $2}')
Dusage_percentage=$(df -H --total | grep "total" | awk  '{printf("%.f", ($3/$2)*100)}')
cpu_load=$(top -bn2 | grep "%Cpu(s)" | awk 'NR==2'| awk '{print $2 "%"}')
last_boot=$(who -b | awk '{print $3 " " $4}')
check_lvm=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")
number_conection=$(ss -t | grep ESTAB | wc -l)
users_log=$(users | wc -w)
ipv4_address=$(hostname -I)
mac_address=$(ip a | grep 'link/ether' | awk '{print($2)}')

wall "
	#Architecture : $architecture
	#CPU physical : $cpu
	#vCPU : $vcpu
	#Memory Usage : $used_rm/$total_rm MB ($used_by_precentage%)
	#Disk Usage : $Diskused/$Disktotal GB ($Dusage_percentage%)
	#CPU Load : $cpu_load
	#Last boot : $last_boot
	#LVM use : $check_lvm
	#Connections TCP : $number_conection ESTABLISHED
	#User log : $users_log
	#Network : IP $ipv4_address ($mac_address)
"

