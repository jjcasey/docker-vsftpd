FROM debian-security-apt-cacher-ng:latest
COPY identity/ /tmp/identity/
COPY setup/ /usr/local/debian-base-setup/
RUN /usr/local/debian-base-setup/040-vsftpd
COPY preinit/ /usr/local/preinit/
EXPOSE 20 21 21100-21110
CMD ["/usr/local/bin/boot-debian-base"]
