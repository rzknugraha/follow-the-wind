# 🌬️ Follow The Wind

Follow The Wind is a reusable Docker-based development environment.

The goal of this repository is to provide reusable runtime environments and supporting infrastructure services. Application code can stay in a separate repository and be mounted into the environment when needed.

---

## 🎯 Purpose

This repository is designed for:

- Reusable local development environments
- Python runtime environment for external repositories
- Standalone infrastructure stacks
- PHP + Nginx environment
- PostgreSQL, MySQL, Redis, MongoDB, Kafka, Zookeeper, Elasticsearch, and Kibana lab services
- Testing integration between services
- Running scripts or applications from another repository through volume mounting

---

## 🧱 Current Structure

```text
follow-the-wind/
├── nginx/
│   └── site.conf
├── php/
│   ├── Dockerfile
│   └── php.ini
├── python/
│   ├── Dockerfile
│   ├── docker-compose.yaml
│   └── requirements.txt
├── stacks/
│   ├── elastic/
│   │   └── docker-compose.yaml
│   ├── kafka-zookeeper/
│   │   └── docker-compose.yaml
│   ├── mongodb/
│   │   └── docker-compose.yaml
│   ├── mysql/
│   │   └── docker-compose.yaml
│   ├── nginx-php/
│   │   └── docker-compose.yaml
│   ├── postgres/
│   │   └── docker-compose.yaml
│   └── redis/
│       └── docker-compose.yaml
├── .env-example
├── .gitignore
├── CONTRIBUTING.md
├── docker-compose.yaml
├── Makefile
└── README.md
```

---

## 🐍 Python Environment Concept

The Python container is intended to work as an environment only.

Your actual Python application or scripts can live in another repository. Configure the external repository path in `.env-example` or in your own `.env` file:

```env
APP_PATH=../external-python-app
```

When the Python container starts, the external folder is mounted inside the container as:

```text
/workspace
```

Inside the container, you can run your code like this:

```bash
cd /workspace
python main.py
```

Start the standalone Python environment:

```bash
make python-up
```

Enter the Python container:

```bash
make python-shell
```

---

## ⚙️ Environment Variables

This repository includes `.env-example` for safe default configuration.

Example:

```env
PG_USER=admin
PG_PASSWORD=admin
PG_DATABASE=app_db

MYSQL_ROOT_PASSWORD=root_password
MYSQL_DATABASE=app_db
MYSQL_USER=app_user
MYSQL_PASSWORD=app_password

KONGA_TOKEN_SECRET=change_this_token_secret
APP_PATH=../external-python-app
```

The Makefile uses `.env-example` by default.

You can also create your own local `.env` file:

```bash
cp .env-example .env
```

Then run commands with:

```bash
make up ENV_FILE=.env
```

The `.env` file is ignored by Git and should not be committed.

---

## 🧰 Makefile Commands

This repository includes a `Makefile` to simplify common Docker commands.

Show available commands:

```bash
make help
```

### Root compose commands

Start all services from the root compose file:

```bash
make up
```

Stop all services from the root compose file:

```bash
make down
```

Build all services from the root compose file:

```bash
make build
```

### Python environment commands

Build only the Python environment:

```bash
make python-build
```

Start only the Python environment:

```bash
make python-up
```

Enter the Python container:

```bash
make python-shell
```

Stop the Python environment:

```bash
make python-down
```

### Standalone stack commands

Start Redis:

```bash
make stack-redis-up
```

Start PostgreSQL:

```bash
make stack-postgres-up
```

Start MySQL:

```bash
make stack-mysql-up
```

Start MongoDB:

```bash
make stack-mongodb-up
```

Start Elasticsearch and Kibana:

```bash
make stack-elastic-up
```

Start Kafka and Zookeeper:

```bash
make stack-kafka-up
```

Start Nginx and PHP:

```bash
make stack-nginx-php-up
```

Stop a standalone stack by replacing `up` with `down`, for example:

```bash
make stack-redis-down
make stack-mysql-down
make stack-elastic-down
make stack-kafka-down
```

View logs by replacing `up` with `logs`, for example:

```bash
make stack-redis-logs
make stack-mysql-logs
make stack-elastic-logs
make stack-kafka-logs
```

---

## 🔌 Standalone Stack Ports

| Stack | Service | Host Port | Container Hostname |
|---|---|---:|---|
| Redis | Redis | `6379` | `redis` |
| PostgreSQL | PostgreSQL | `5432` | `postgres` |
| MySQL | MySQL | `3306` | `mysql` |
| MongoDB | MongoDB | `27017` | `mongodb` |
| Elastic | Elasticsearch | `9200`, `9300` | `elasticsearch` |
| Elastic | Kibana | `5601` | `kibana` |
| Kafka | Zookeeper | `2181` | `zookeeper` |
| Kafka | Kafka | `9092`, `9093` | `kafka` |
| Nginx PHP | Nginx | `8081` | `nginx` |
| Nginx PHP | PHP-FPM | internal only | `php` |

Inside Docker containers, use service names instead of `localhost`.

Example PostgreSQL connection from Python:

```python
import os
import psycopg2

conn = psycopg2.connect(
    host="postgres",
    port=5432,
    user=os.getenv("PG_USER"),
    password=os.getenv("PG_PASSWORD"),
    database=os.getenv("PG_DATABASE", "app_db")
)

print("Connected to PostgreSQL")
```

Example MySQL connection from Python:

```python
import os
import mysql.connector

conn = mysql.connector.connect(
    host="mysql",
    port=3306,
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD"),
    database=os.getenv("MYSQL_DATABASE", "app_db")
)

print("Connected to MySQL")
```

---

## 🧪 Python Installed Libraries

The Python environment uses `python/requirements.txt`.

Current libraries include:

```text
pandas
openpyxl
psycopg2-binary
elasticsearch
numpy
yagmail
python-dotenv
fastapi
uvicorn[standard]
python-multipart
```

After changing `python/requirements.txt`, rebuild the Python environment:

```bash
make python-build
```

---

## 📝 Commit Message Convention

This repository uses a simple commit message pattern:

```text
<type>: <short message>
```

Examples:

```text
feat: add standalone redis stack
fix: correct python compose env path
docs: update readme usage instructions
```

Common types include `feat`, `fix`, `docs`, `chore`, `refactor`, `style`, `test`, `build`, `ci`, `perf`, and `revert`.

See `CONTRIBUTING.md` for the full convention.

---

## 🗺️ Recommended Direction

The recommended long-term direction is to use each folder as a standalone environment or stack:

```text
python/                    # reusable Python runtime
stacks/redis/              # standalone Redis
stacks/postgres/           # standalone PostgreSQL
stacks/mysql/              # standalone MySQL
stacks/mongodb/            # standalone MongoDB
stacks/elastic/            # standalone Elasticsearch + Kibana
stacks/kafka-zookeeper/    # standalone Kafka + Zookeeper
stacks/nginx-php/          # standalone Nginx + PHP
```

This makes the repository easier to reuse for different projects.

---

## ⚠️ Notes

Avoid using Docker images with the `latest` tag for serious development or production-like testing. Fixed versions make the environment more predictable.

---

## 📄 License

This project is open-source and available under the MIT License.
