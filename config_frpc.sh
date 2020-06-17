#! /bin/bash
cat /home/pi/frp/frpc.ini > /home/pi/frp/frpc-gcdt.ini
#get mac address
NIC=eth0
MAC=`LANG=C ifconfig $NIC | awk '/ether/{ print $2 }' | sed 's/://g' `
hostname $MAC
echo "[$MAC]" >> /home/pi/frp/frpc-gcdt.ini
echo "type = tcp" >> /home/pi/frp/frpc-gcdt.ini
echo "local_ip = 127.0.0.1" >> /home/pi/frp/frpc-gcdt.ini
echo "local_port = 22" >> /home/pi/frp/frpc-gcdt.ini
#change mac to num and use last 4 number to be remote port
#MACINNUM=`echo $MAC | awk -F ":" '{printf("%d%d%d%d%d%d\n"),strtonum("0x"$1),strtonum("0x"$2),strtonum("0x"$3),strtonum("0x"$4),strtonum("0x"$2),strtonum("0x"$6)}'`
MACINNUM=$((16#$MAC))
MACINFOUR=${MACINNUM:0-4}
echo "remote_port = 2${MACINFOUR}" >> /home/pi/frp/frpc-gcdt.ini
