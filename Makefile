# Follow The Wind - helper commands

ENV_FILE ?= .env-example
COMPOSE ?= docker compose --env-file $(ENV_FILE)
PYTHON_COMPOSE ?= docker compose --env-file $(ENV_FILE) -f python/docker-compose.yaml
PYTHON_CONTAINER ?= python_env

STACK_REDIS ?= docker compose -f stacks/redis/docker-compose.yaml
STACK_POSTGRES ?= docker compose --env-file $(ENV_FILE) -f stacks/postgres/docker-compose.yaml
STACK_MYSQL ?= docker compose --env-file $(ENV_FILE) -f stacks/mysql/docker-compose.yaml
STACK_MONGODB ?= docker compose -f stacks/mongodb/docker-compose.yaml
STACK_ELASTIC ?= docker compose -f stacks/elastic/docker-compose.yaml
STACK_KAFKA ?= docker compose -f stacks/kafka-zookeeper/docker-compose.yaml
STACK_NGINX_PHP ?= docker compose -f stacks/nginx-php/docker-compose.yaml

.DEFAULT_GOAL := help

.PHONY: help up down build restart ps logs clean \
	python-build python-up python-down python-shell python-logs python-ps \
	stack-redis-up stack-redis-down stack-redis-logs \
	stack-postgres-up stack-postgres-down stack-postgres-logs \
	stack-mysql-up stack-mysql-down stack-mysql-logs \
	stack-mongodb-up stack-mongodb-down stack-mongodb-logs \
	stack-elastic-up stack-elastic-down stack-elastic-logs \
	stack-kafka-up stack-kafka-down stack-kafka-logs \
	stack-nginx-php-up stack-nginx-php-down stack-nginx-php-logs \
	postgres-up redis-up mongo-up elastic-up kafka-up kong-up

help:
	@echo "Available commands:"
	@echo "  make up                         Start all services from root compose"
	@echo "  make down                       Stop all services from root compose"
	@echo "  make build                      Build all services from root compose"
	@echo "  make restart                    Restart all services from root compose"
	@echo "  make ps                         Show running containers from root compose"
	@echo "  make logs                       Show all logs from root compose"
	@echo "  make clean                      Stop services and remove volumes from root compose"
	@echo ""
	@echo "Standalone Python environment:"
	@echo "  make python-build               Build Python environment"
	@echo "  make python-up                  Start Python environment"
	@echo "  make python-down                Stop Python environment"
	@echo "  make python-shell               Enter Python container"
	@echo "  make python-logs                Show Python logs"
	@echo "  make python-ps                  Show Python compose status"
	@echo ""
	@echo "Standalone infrastructure stacks:"
	@echo "  make stack-redis-up             Start Redis stack"
	@echo "  make stack-postgres-up          Start PostgreSQL stack"
	@echo "  make stack-mysql-up             Start MySQL stack"
	@echo "  make stack-mongodb-up           Start MongoDB stack"
	@echo "  make stack-elastic-up           Start Elasticsearch + Kibana stack"
	@echo "  make stack-kafka-up             Start Kafka + Zookeeper stack"
	@echo "  make stack-nginx-php-up         Start Nginx + PHP stack"
	@echo ""
	@echo "Selected root services:"
	@echo "  make postgres-up                Start PostgreSQL from root compose"
	@echo "  make redis-up                   Start Redis from root compose"
	@echo "  make mongo-up                   Start MongoDB from root compose"
	@echo "  make elastic-up                 Start Elasticsearch and Kibana from root compose"
	@echo "  make kafka-up                   Start Zookeeper and Kafka from root compose"
	@echo "  make kong-up                    Start Kong and Konga from root compose"
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

stack-redis-up:
	$(STACK_REDIS) up -d

stack-redis-down:
	$(STACK_REDIS) down

stack-redis-logs:
	$(STACK_REDIS) logs -f

stack-postgres-up:
	$(STACK_POSTGRES) up -d

stack-postgres-down:
	$(STACK_POSTGRES) down

stack-postgres-logs:
	$(STACK_POSTGRES) logs -f

stack-mysql-up:
	$(STACK_MYSQL) up -d

stack-mysql-down:
	$(STACK_MYSQL) down

stack-mysql-logs:
	$(STACK_MYSQL) logs -f

stack-mongodb-up:
	$(STACK_MONGODB) up -d

stack-mongodb-down:
	$(STACK_MONGODB) down

stack-mongodb-logs:
	$(STACK_MONGODB) logs -f

stack-elastic-up:
	$(STACK_ELASTIC) up -d

stack-elastic-down:
	$(STACK_ELASTIC) down

stack-elastic-logs:
	$(STACK_ELASTIC) logs -f

stack-kafka-up:
	$(STACK_KAFKA) up -d

stack-kafka-down:
	$(STACK_KAFKA) down

stack-kafka-logs:
	$(STACK_KAFKA) logs -f

stack-nginx-php-up:
	$(STACK_NGINX_PHP) up -d --build

stack-nginx-php-down:
	$(STACK_NGINX_PHP) down

stack-nginx-php-logs:
	$(STACK_NGINX_PHP) logs -f

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
