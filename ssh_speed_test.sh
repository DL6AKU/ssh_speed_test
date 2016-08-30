#!/bin/bash
function cleanup()
{
	rm /tmp/ssh_speed_test.img
	exit 1
}
trap cleanup INT

if [ -z $(which bc) ]; then
	echo "ERROR: You need to install 'bc' to run this script."
	exit 2
fi

if [ -z $(which time) ]; then
	echo "ERROR: You need to install 'time' to run this script."
	exit 2
fi

ssh -o PasswordAuthentication=no localhost /bin/true
if [ $? -gt 0 ]; then
	echo "ERROR: You need to be able to ssh to localhost via certificate authentication."
	exit 3
fi

cd /tmp

uname -a
ssh -V
echo "CPU:      $(cat /proc/cpuinfo | grep "model name" | tail -n 1 | cut -d ':' -f 2) (Number of cores: $(cat /proc/cpuinfo | grep processor | wc -l))"
echo "CPU flags:$(cat /proc/cpuinfo | grep "flags" | tail -n 1 | cut -d ':' -f 2)"
echo



if [ ! -e ssh_speed_test.img ]; then
	echo -n "Creating test file, please wait... "
	dd if=/dev/urandom of=ssh_speed_test.img bs=1M count=384 >/dev/null 2>&1
	echo "Done"
fi

CIPHERS=(
	"chacha20-poly1305@openssh.com"
	"aes128-ctr"
	"aes256-ctr"
	"aes128-gcm@openssh.com"
	"aes256-gcm@openssh.com"
	"arcfour"
	"arcfour128"
	"arcfour256"
	"blowfish-cbc"
	"cast128-cbc"
	"3des-cbc"
)


echo "Starting Benchmark:"
echo
echo "+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+"
echo "|             CIPHER             |   TIME (s)   |     CPU      | SPEED (MB/s) |                       SPEED (bar graph)                      |"
echo "+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+"

for cipher in ${CIPHERS[@]}; do
	RESULTS=$(/usr/bin/time -f "%e:%P" scp -o PasswordAuthentication=no -o VisualHostKey=no -q -c $cipher ssh_speed_test.img localhost:/dev/null 2>&1)
	if [ $? -gt 0 ]; then
		printf "|%32s|" "$cipher "
		echo "     n/a      |     n/a      |     n/a      |            cipher not enabled in /etc/sshd_config            |"
	else
		TIME=$(printf "%7.2f" $(echo $RESULTS | cut -d ':' -f 1))
		CPU=$(printf "%5s" $(echo $RESULTS | cut -d ':' -f 2))
		SPEED=$(printf "%7.2f" $(echo "384 / $TIME"|bc -l))
		PLUSSES_NR=$(echo "$SPEED/10" | bc)
		printf "|%32s|" "$cipher "
		echo -n "  ${TIME}     |    $CPU     |   ${SPEED}    | "

		PLUSSES=""
		if [ $PLUSSES_NR -gt 60 ]; then
			PLUSSES=" +++ more than 60 (MAXED OUT) ++++++++++++++++++++++++++++++"
		else
			for ((i=0; i<=$PLUSSES_NR; i++)); do
				PLUSSES="${PLUSSES}+"
			done
		fi
		printf "%-60s" "$(echo $PLUSSES)"
		echo " |"
	fi
	
done

echo "+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+"
cd $OLDPWD
