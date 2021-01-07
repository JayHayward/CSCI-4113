#!/bin/bash
#
# Jay Hayward
# CSCI-4113
# Lab 1.2
# System Dashboard


echo -e '\t'
echo "CPU AND MEMORY RESOURCES-----------------------------------"
load_avg=$(uptime | awk -F '[,:]' '{print $6","$7","$8}')
free_ram=$(free -m | awk '{print $4}' | head -n 2 | tail -n 1)
echo -e "CPU Load Average:$load_avg \t Free RAM: $free_ram MB"
echo -e '\n'


echo "NETWORK CONNECTIONS----------------------------------------"
io_rec=$(cat /proc/net/dev | awk '{print $2}' | tail -n 1)
io_tran=$(cat /proc/net/dev | awk '{print $10}' | tail -n 1)
echo -e "IO Bytes Recieved: $io_rec \t Bytes Transmitted: $io_tran"

enp0s3_rec=$(cat /proc/net/dev | awk '{print $2}' | head -n 3 | tail -n 1)
enp0s3_tran=$(cat /proc/net/dev | awk '{print $10}' | head -n 3 | tail -n 1)
echo -e "enp0s3 Bytes Recieved: $enp0s3_rec \t Bytes Transmitted: $enp0s3_tran"

connected=$(ping 8.8.8.8 | echo $?)
if (( $connected ))
then
	echo -e "Internet Connectivity: Not Connected"
else	
	echo -e "Internet Connectivity: Connected"
fi
echo -e '\n'


echo "ACCOUNT INFORMATION----------------------------------------"
echo -e "Total users: $(cat /etc/passwd | awk -F ':' '{print $1}' | wc -l) \t \t Number Active: $(who | wc -l)"


sh_total=$(cat /etc/passwd | awk -F ":" '{print $7}')

shells=$(echo $sh_total | sed -E 's/ /\n/g' | sort -u)

echo -e "\nShells:"
for she in $shells; do
	echo "$she: $(echo $sh_total | sed -E 's/ /\n/g' | grep -c $she)"
done

echo -e '\n'


echo "FILESYSTEM INFORMATION--------------------------------------"
echo -e "Total Number of Files: $(find / -type f | wc -l)"
echo -e "Total Number of Directories: $(find / -type d | wc -l)"
echo -e '\n' 

