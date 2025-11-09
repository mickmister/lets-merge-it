# Dockerfile
FROM lscr.io/linuxserver/code-server:4.105.1

# stay root here; LSIO entrypoint will drop privileges
RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
