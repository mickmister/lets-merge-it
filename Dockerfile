FROM lscr.io/linuxserver/code-server:4.105.1

RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip zsh build-essential python3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
