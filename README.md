# 🌬️ Follow The Wind

A simple and modular Docker-based development environment starter kit. This project helps you spin up services like **Nginx**, **PHP**, and optionally **Python**, to jumpstart your local development with a clean and reusable setup.

---

## 📦 Features

- ✅ Lightweight Docker environment
- ✅ Easily configurable Nginx + PHP-FPM stack
- ✅ Extendable with Python (Flask/FastAPI) service
- ✅ Volume mapping for live development
- ✅ Ready to expand for full-stack web apps

---

## 🧱 Folder Structure

```
follow-the-wind/
├── nginx/              # Nginx configuration files
├── php/                # PHP setup and files
├── python/             # (Optional) Python app setup
├── .env                # Environment variables
├── .gitignore
├── docker-compose.yaml
└── README.md
```

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/rzknugraha/follow-the-wind.git
cd follow-the-wind
```

### 2. Set up Environment Variables
Create a `.env` file (if not present):
```env
# Example .env
PG_USER=admin
PG_PASSWORD=admin
```

### 3. Start the Services
```bash
docker-compose up --build
```

> Visit `http://localhost` to see your project running.

---

## 🐍 Optional: Add Python (Flask) Service

1. Add a `python/` folder with your Python app (e.g. `app.py`)
2. Update `docker-compose.yaml` to include:

```yaml
python:
  build: ./python
  ports:
    - "8000:8000"
  volumes:
    - ./python:/app
```

3. Rebuild:
```bash
docker-compose up --build
```

---

## 🔧 To Do / Improvements

- [ ] Add MySQL/Postgres support
- [ ] Add Node.js service for frontend
- [ ] Set up Laravel or Django boilerplate
- [ ] Write automated tests
- [ ] Add Nginx HTTPS support

---

## 🧑‍💻 Author

**Rizky Nugraha**  
[GitHub](https://github.com/rzknugraha)
<!-- [LinkedIn](#) · [Portfolio](#) -->

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).