#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c() {
	echo -e "\n\n${redColour}[!] Exiting...${endColour}"
	rm /tmp/${0}.log 2>/dev/null
	exit 0
}
trap ctrl_c INT

function jump(){
	echo
	for i in {1..100}; do echo -en "${turquoiseColour}-${endColour}";done
	echo -e "\n"
}

# CPU
idle=$(top -bn1 | grep ^'%Cpu(s):' | sed 's/100,0/ 100,0/' | sed 's/\./\,/g' | awk '{print $8}' | sed 's/,//')
usage=$((100 - ${idle:0:-1}))
por=$((usage ))
if [ ${usage: 0: -1} -lt 10 ]; then
	echo -e "${grayColour}CPU usage: ${blueColour}$usage%${endColour}"
else
	echo -e "${grayColour}CPU usage: ${redColour}$usage%${endColour}"
fi
jump

# RAM
total=$(free | tail -n +2 | awk '{print $2}' | head -n 1)
us=$(free | tail -n +2 | awk '{print $3}' | head -n 1)
por=$(($us * 100 / $total))

if [ $por -lt 90 ]; then
	echo -e "${grayColour}RAM usage: ${blueColour}$por%${endColour}"
else
	echo -e "${grayColour}RAM usage: ${redColour}$por%${endColour}"
fi
jump

# DISK
df -h > /tmp/${0}.log
head -n 1 /tmp/${0}.log
i=1
while read -r s b use disp usepor mount; do
	if [ $i -eq 1 ]; then
		i=$((i+1))
		continue
	fi
	if [ ${usepor:0:-1} -lt 90 ]; then
		echo -e "${blueColour}$(head -n $i /tmp/${0}.log | tail -n 1)${endColour}"
	else
		echo -e "${redColour}$(head -n $i /tmp/${0}.log | tail -n 1)${endColour}"
	fi
	i=$((i+1))
done <<< $(df -h)
rm /tmp/${0}.log
jump

# PROCESES
echo -e "${grayColour}5 proceses by CPU:\n${greenColour}$(ps aux --sort=-%cpu | head -n 5)${endColour}"
echo -e "\n${grayColour}5 proceses by RAM:\n${greenColour}$(ps aux --sort=-%mem | head -n 5)${endColour}"
jump

# LOGIN FAIL
echo -e "${grayColour}Login failed:${endColour}"
echo -e "\n${redColour}SU${endColour}"
journalctl -q -b -g "FAILED SU" | grep -v "COMMAND"
echo -e "\n${redColour}SSH${endColour}"
journalctl -q -b -g "Failed password" | grep -v "COMMAND"

jump

# EXTRA
echo -e "${grayColour}EXTRA\n${greenColour}$(w)${endColour}"
