.PHONY: help build up down restart logs logs-code logs-caddy shell-code shell-caddy clean rebuild

# Default target
help:
	@echo "Available commands:"
	@echo "  make build       - Build Docker images (code-server)"
	@echo "  make up          - Start Docker services (code-server + Caddy)"
	@echo "  make down        - Stop Docker services"
	@echo "  make restart     - Restart Docker services"
	@echo "  make logs        - View logs from all Docker services"
	@echo "  make logs-code   - View code-server logs"
	@echo "  make logs-caddy  - View Caddy logs"
	@echo "  make shell-code  - Open shell in code-server container"
	@echo "  make shell-caddy - Open shell in Caddy container"
	@echo "  make clean       - Stop and remove all containers and volumes"
	@echo "  make rebuild     - Rebuild and restart all services"
	@echo ""
	@echo "Note: Your app runs on the host (port 1340). Start it with 'pnpm dev' or similar."

# Build all images
build:
	docker-compose build

# Start all services
up:
	docker-compose up -d

# Stop all services
down:
	docker-compose down

# Restart all services
restart:
	docker-compose restart

# View all logs
logs:
	docker-compose logs -f

# View code-server logs
logs-code:
	docker-compose logs -f code-server

# View Caddy logs
logs-caddy:
	docker-compose logs -f caddy

# Open shell in code-server container
shell-code:
	docker-compose exec code-server bash

# Open shell in Caddy container
shell-caddy:
	docker-compose exec caddy sh

# Clean everything (removes volumes!)
clean:
	@echo "WARNING: This will remove all containers and volumes!"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		docker-compose down -v; \
	fi

# Rebuild and restart
rebuild:
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d
