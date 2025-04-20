# python.Dockerfile

FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /env

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    unzip \
    && apt-get clean

# Install common Python libraries (optional)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Keep container alive without running a script
CMD ["tail", "-f", "/dev/null"]
