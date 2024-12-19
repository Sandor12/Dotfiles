#!/bin/bash

if [ "${USER}" != "root" ]; then
	echo "you must run the script as root"
	exit 1
fi

problem=false

pacman -S --needed clamav python-fangfrisch apparmor

freshclam

systemctl enable --now clamav-freshclam.service
systemctl enable --now clamav-daemon.service

if [ $(curl https://secure.eicar.org/eicar.com.txt | clamscan - | grep "Win.Test.EICAR_HDB-1 FOUND") ]; then
	problem=true
fi

cp /etc/clamav/clamd.conf /etc/clamav/clamdold.conf.bak
echo "clamav conf backed up in /etc/clamav/clamdold.conf.bak"

echo "LogFile /var/log/clamav/clamd.log" >/etc/clamav/clamd.conf
echo "LogTime yes" >>/etc/clamav/clamd.conf
echo "PidFile /run/clamav/clamd.pid"
echo "TemporaryDirectory /tmp"
echo "LocalSocket /run/clamav/clamd.ctl"

{
	echo "OnAccessMountPath /"
	echo "OnAccessMountPath /home"
	echo "OnAccessMountPath /var/cache/pacman/pkg"
	echo "OnAccessMountPath /var/log"
	echo "OnAccessExcludePath /proc"
	echo "OnAccessExcludePath /run"
	echo "OnAccessExcludePath /sys"
	echo "OnAccessExcludePath /etc"
	echo "OnAccessExtraScanning true"
	echo "OnAccessExcludeUname clamav"
	echo "User clamav"
} >>/etc/clamav/clamd.conf
echo "New configuration finished"

sudo -u clamav /usr/bin/fangfrisch --conf /etc/fangfrisch/fangfrisch.conf initdb

systemctl enable --now fangfrisch.timer
systemctl restart clamav-daemon.service

{
	echo "# clamonacc systemd service file primarily the work of ChadDevOps & Aaron Brighton"
	echo "# See: https://medium.com/@aaronbrighton/installation-configuration-of-clamav-antivirus-on-ubuntu-18-04-a6416bab3b41#a340"
	printf "\n"
	echo "[Unit]"
	echo "Description=ClamAV On-Access Scanner"
	echo "Documentation=man:clamonacc(8) man:clamd.conf(5) https://docs.clamav.net/"
	echo "Requires=clamav-daemon.service"
	echo "After=clamav-daemon.service syslog.target network.target"
	printf "\n"
	echo "[Service]"
	echo "Type=simple"
	echo "User=root"
	echo 'ExecStartPre=/bin/bash -c "while [ ! -S /run/clamav/clamd.ctl ]; do sleep 1; done"'
	echo "ExecStart=/usr/sbin/clamonacc --fdpass  -F --log=/var/log/clamav/clamonacc.log --move=/root/quarantine"
	printf "\n"
	echo "[Install]"
	echo "WantedBy=multi-user.target"
} >/etc/systemd/system/multi-user.target.wants/clamav-clamonacc.service
echo "systemd unit file for clamav on access scanning "

systemctl daemon-reload
aa-complain clamd
systemctl enable clamav-clamonacc.service

if [ ${problem} ]; then
	echo "clamav had a problem but the configation is still ended"
else
	echo "Everything good clamav on access scanning setup"
fi
