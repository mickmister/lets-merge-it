FROM lscr.io/linuxserver/code-server:latest

USER root
RUN apt update && apt install -y unzip && apt clean

USER abc
