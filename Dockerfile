FROM --platform=${TARGETPLATFORM:-linux/arm64} ubuntu:20.04

ARG HOOBS_VERSION=4.2.*
ENV LANG=en_US.UTF-8 \
LANGUAGE=en_US.UTF-8 \
LC_ALL=en_US.UTF-8 \
TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y curl wget sudo locales lsb-release
RUN sudo locale-gen en_US en_US.UTF-8; sudo dpkg-reconfigure locales
RUN wget -qO- https://dl.hoobs.org/stable | sudo bash -
RUN apt install -y hoobsd=${HOOBS_VERSION} hoobs-cli=${HOOBS_VERSION} hoobs-gui=${HOOBS_VERSION}
RUN apt install -y bluetooth wpasupplicant network-manager avahi-daemon avahi-utils dnsmasq
RUN apt-get clean
RUN sudo hbs install -p 8080
RUN adduser --gecos hoobs --disabled-password hoobs
RUN echo "hoobs ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN adduser hoobs sudo
RUN echo "hoobs:hoobsadmin" | chpasswd
RUN passwd -l root
RUN echo "hoobs" > /etc/hostname
RUN sudo rm -rf /var/lib/apt/lists/*

VOLUME /hoobs
WORKDIR /hoobs

EXPOSE 8080/tcp

ENTRYPOINT ["/bin/bash", "-c", "sudo hbs install -p 8080;hoobsd hub"]
# CMD ["/bin/bash", "-c", "sudo hbs install -p 80;hoobsd hub"]
