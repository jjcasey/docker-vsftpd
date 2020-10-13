#! /bin/sh
docker container rm vsftpd || /bin/true
docker run -td \
	--restart always \
	-e DEBBASE_SYSLOG=stdout \
	-e DEBBASE_TIMEZONE=`cat /etc/timezone` \
	-e VSFTPD_CONF=/var/lib/vsftpd/vsftpd.conf \
	-e VSFTPD_PAMD=/var/lib/vsftpd/vsftpd_virtual \
	-e VSFTPD_VIRTUAL_USERS=/var/lib/vsftpd/virtual_users.txt \
	--stop-signal=SIGRTMIN+3 \
	--tmpfs /run:size=100M \
	--tmpfs /run/lock:size=100M \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	-v /srv/ftp:/srv/ftp \
	-v ${PWD}/virtual_users.txt:/var/lib/vsftpd/virtual_users.txt \
	-v ${PWD}/vsftpd.conf:/var/lib/vsftpd/vsftpd.conf \
	-v ${PWD}/vsftpd_virtual:/var/lib/vsftpd/vsftpd_virtual \
	-p 20:20 \
	-p 21:21 \
	-p 21100-21110:21100-21110 \
	--network lan-services \
	--name=vsftpd \
	vsftpd
