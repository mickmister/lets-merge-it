FROM lscr.io/linuxserver/code-server:4.105.1

USER root
RUN apt update && apt install -y unzip openssh-client && apt clean

USER abc
