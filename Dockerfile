FROM python:3.9.5-slim-buster
RUN apt-get update && apt-get install -y --no-install-recommends --yes \
    vim \
    curl \
    netcat \
    && rm -rf /var/lib/apt/lists/*