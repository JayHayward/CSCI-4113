#!/bin/bash
#
# Jay Hayward
# CSCI-4113
# Lab 1.1
# Space Utilization

root_msg="Root directory exceeded space utilization threshhold!"
boot_msg="Boot directory exceeded space utilization threshhold!"

threshhold=80
while :
do
	dir_root=$(df | awk '$6 == "/" {print $5}')
	dir_boot=$(df | awk '$6 == "/boot" {print $5}')
	
	u_root=${dir_root::-1}
	u_boot=${dir_boot::-1}

	if (( $u_root >= $threshhold ))
	then
		echo -e "$root_msg \nRoot is using $u_root% of available space" | mailx -s root_utilization root
		break
	elif (( $u_boot >= $threshhold ))
	then
		echo -e "$boot_msg \nBoot is using $u_Boot% of available space" | mailx -s boot_utilization root
		break
	fi
#	echo "sleep"
	sleep 30
done


#echo $u_root
#echo $u_boot
#total=$(( u_root + u_boot ))
