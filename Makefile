# Follow The Wind - helper commands

ENV_FILE ?= .env-example
COMPOSE ?= docker compose --env-file $(ENV_FILE)
PYTHON_COMPOSE ?= docker compose --env-file $(ENV_FILE) -f python/docker-compose.yaml
PYTHON_CONTAINER ?= python_env

.DEFAULT_GOAL := help

.PHONY: help up down build restart ps logs clean \
	python-build python-up python-down python-shell python-logs python-ps \
	postgres-up redis-up mongo-up elastic-up kafka-up kong-up

help:
	@echo "Available commands:"
	@echo "  make up              Start all services from root compose"
	@echo "  make down            Stop all services from root compose"
	@echo "  make build           Build all services from root compose"
	@echo "  make restart         Restart all services from root compose"
	@echo "  make ps              Show running containers from root compose"
	@echo "  make logs            Show all logs from root compose"
	@echo "  make clean           Stop services and remove volumes from root compose"
	@echo ""
	@echo "Standalone Python environment:"
	@echo "  make python-build    Build Python environment"
	@echo "  make python-up       Start Python environment"
	@echo "  make python-down     Stop Python environment"
	@echo "  make python-shell    Enter Python container"
	@echo "  make python-logs     Show Python logs"
	@echo "  make python-ps       Show Python compose status"
	@echo ""
	@echo "Selected root services:"
	@echo "  make postgres-up     Start PostgreSQL"
	@echo "  make redis-up        Start Redis"
	@echo "  make mongo-up        Start MongoDB"
	@echo "  make elastic-up      Start Elasticsearch and Kibana"
	@echo "  make kafka-up        Start Zookeeper and Kafka"
	@echo "  make kong-up         Start Kong and Konga"
	@echo ""
	@echo "Default env file: $(ENV_FILE)"
	@echo "Use another env file with: make up ENV_FILE=.env"

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

build:
	$(COMPOSE) build

restart:
	$(COMPOSE) down
	$(COMPOSE) up -d

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

clean:
	$(COMPOSE) down -v

python-build:
	$(PYTHON_COMPOSE) build

python-up:
	$(PYTHON_COMPOSE) up -d

python-down:
	$(PYTHON_COMPOSE) down

python-shell:
	docker exec -it $(PYTHON_CONTAINER) bash

python-logs:
	docker logs -f $(PYTHON_CONTAINER)

python-ps:
	$(PYTHON_COMPOSE) ps

postgres-up:
	$(COMPOSE) up -d dbPG

redis-up:
	$(COMPOSE) up -d redis

mongo-up:
	$(COMPOSE) up -d mongodb

elastic-up:
	$(COMPOSE) up -d elasticsearch kibana

kafka-up:
	$(COMPOSE) up -d zookeeper kafka

kong-up:
	$(COMPOSE) up -d dbPG kong-migration kong konga-prepare konga
