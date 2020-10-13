#! /bin/sh
adduser --system --group --home /srv/ftp ftp
mkdir -p identity
getent passwd ftp > identity/passwd
getent group ftp > identity/group
getent shadow ftp > identity/shadow
docker network create -d bridge lan-services || /bin/true
docker build --network lan-services -t vsftpd .
