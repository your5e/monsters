FROM python:3.12-slim

LABEL project="your5e-monsters"

RUN     apt-get update \
    &&  apt-get install --no-install-recommends --yes \
            libpango-1.0-0 \
            libpangocairo-1.0-0 \
            libgdk-pixbuf-2.0-0 \
            libffi-dev \
            fonts-dejavu-core \
    &&  rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
