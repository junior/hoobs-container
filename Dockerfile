FROM --platform=${TARGETPLATFORM:-linux/arm64} ubuntu:20.04

ARG HOOBS_VERSION=4.2.*
ENV LANG=en_US.UTF-8 \
LANGUAGE=en_US.UTF-8 \
LC_ALL=en_US.UTF-8
RUN apt update && apt install curl wget sudo locales -y
RUN wget -qO- https://dl.hoobs.org/stable | sudo bash -
RUN apt install hoobsd=${HOOBS_VERSION} hoobs-cli=${HOOBS_VERSION} hoobs-gui=${HOOBS_VERSION} -y
RUN sudo rm -rf /var/lib/apt/lists/*
RUN sudo locale-gen en_US en_US.UTF-8; sudo dpkg-reconfigure locales
RUN sudo hbs install -p 8080

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", "sudo hbs install -p 80;hoobsd hub"]
# CMD ["/bin/bash", "-c", "sudo hbs install -p 80;hoobsd hub"]
