# 🌬️ Follow The Wind

Follow The Wind is a reusable Docker-based development environment.

The goal of this repository is to provide reusable runtime environments and supporting infrastructure services. Application code can stay in a separate repository and be mounted into the environment when needed.

---

## 🎯 Purpose

This repository is designed for:

- Reusable local development environments
- Python runtime environment for external repositories
- PHP + Nginx environment
- PostgreSQL, Redis, MongoDB, Kafka, Elasticsearch, Kibana, Kong, and Konga lab services
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
│   └── requirements.txt
├── .env-example
├── .gitignore
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

---

## ⚙️ Environment Variables

This repository includes `.env-example` for safe default configuration.

Example:

```env
PG_USER=admin
PG_PASSWORD=admin
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

## 🚀 Basic Docker Commands

Start all services:

```bash
docker compose --env-file .env-example up -d
```

Stop all services:

```bash
docker compose --env-file .env-example down
```

Build services:

```bash
docker compose --env-file .env-example build
```

View logs:

```bash
docker compose --env-file .env-example logs -f
```

---

## 🧰 Makefile Commands

This repository includes a `Makefile` to simplify common Docker commands.

Show available commands:

```bash
make help
```

Start all services:

```bash
make up
```

Stop all services:

```bash
make down
```

Build all services:

```bash
make build
```

Start only the Python environment:

```bash
make python-up
```

Build only the Python environment:

```bash
make python-build
```

Enter the Python container:

```bash
make python-shell
```

Show Python container logs:

```bash
make python-logs
```

Remove containers and volumes:

```bash
make clean
```

Use a local `.env` file instead of `.env-example`:

```bash
make up ENV_FILE=.env
```

---

## 🔌 Service Connection Names

Inside Docker containers, use service names instead of `localhost`.

| Service | Hostname inside Docker | Port |
|---|---:|---:|
| PostgreSQL | `dbPG` | `5432` |
| Redis | `redis` | `6379` |
| MongoDB | `mongodb` | `27017` |
| Elasticsearch | `elasticsearch` | `9200` |
| Kafka | `kafka` | `9093` |
| Kong Admin API | `kong` | `8001` |
| Kibana | `kibana` | `5601` |

Example PostgreSQL connection from Python:

```python
import os
import psycopg2

conn = psycopg2.connect(
    host="dbPG",
    port=5432,
    user=os.getenv("PG_USER"),
    password=os.getenv("PG_PASSWORD"),
    database="postgres"
)

print("Connected to PostgreSQL")
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

## 🗺️ Recommended Future Structure

Later, this repository can be improved by separating environments and infrastructure stacks:

```text
follow-the-wind/
├── environments/
│   └── python-env/
│       ├── docker-compose.yaml
│       ├── Dockerfile
│       └── requirements.txt
├── stacks/
│   ├── postgres/
│   ├── redis/
│   ├── elastic/
│   ├── kafka/
│   └── kong/
├── Makefile
└── README.md
```

This will make each environment or stack more standalone.

---

## ⚠️ Notes

Avoid using Docker images with the `latest` tag for serious development or production-like testing. Fixed versions make the environment more predictable.

Example:

```yaml
image: kong:3.14
```

---

## 📄 License

This project is open-source and available under the MIT License.
