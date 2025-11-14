# lets-merge-it

A code-server setup with integrated terminal running on the host via SSH.

## Features

- code-server (VS Code in the browser) running in Docker
- Integrated terminal connects to host machine via SSH
- Projects directory mounted for development
- Configuration persisted across container restarts

## Setup

### 1. Generate SSH Key Pair

First, create the SSH keys directory and generate a key pair:

```bash
mkdir -p ssh-keys
ssh-keygen -t rsa -b 4096 -f ssh-keys/id_rsa -N ""
```

### 2. Add Public Key to Host

Add the generated public key to your host's authorized_keys:

```bash
cat ssh-keys/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### 3. Ensure SSH Server is Running on Host

Make sure your host machine has an SSH server running:

```bash
# On Ubuntu/Debian
sudo systemctl status ssh

# If not running, start it
sudo systemctl start ssh
sudo systemctl enable ssh
```

### 4. Start the Container

```bash
docker-compose up -d
```

### 5. Access code-server

Open your browser and navigate to:
```
https://localhost:1337
```

Password: `dev`

### 6. Open Terminal

When you open a new terminal in code-server, it will automatically connect to your host machine via SSH.

## Configuration

- **Projects Directory**: `./projects` - mounted to `/home/coder/project` in the container
- **Config Directory**: `./config` - persists code-server configuration
- **SSH Keys**: `./ssh-keys` - contains the SSH private key for host connection
- **Terminal Settings**: `./config-defaults/data/User/settings.json` - VS Code settings for SSH terminal

## Troubleshooting

### Terminal shows "Connection refused"

1. Verify SSH server is running on host: `sudo systemctl status ssh`
2. Check if the public key is in `~/.ssh/authorized_keys`
3. Verify SSH key permissions: `chmod 600 ssh-keys/id_rsa`

### Terminal shows "Permission denied"

1. Ensure the public key is correctly added to `~/.ssh/authorized_keys`
2. Check file permissions: `chmod 600 ~/.ssh/authorized_keys`
3. Verify SSH directory permissions: `chmod 700 ~/.ssh`

### Want to connect as a different user

Edit `config-defaults/data/User/settings.json` and change the user in the SSH args:
```json
"user@host.docker.internal"
```
Replace `user` with your desired username.

## Security Notes

- The `ssh-keys` directory is excluded from git (see `.gitignore`)
- StrictHostKeyChecking is disabled for convenience in development
- Consider using proper SSH key management for production environments
