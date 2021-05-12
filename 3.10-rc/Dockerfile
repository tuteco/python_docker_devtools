# NOTE: THIS DOCKERFILE IS GENERATED VIA "gen_dockerfile.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
FROM python:3.10-rc-slim
RUN apt-get update && apt-get install -y --no-install-recommends --yes \
    vim \
    curl \
    netcat \
    jq \
    && rm -rf /var/lib/apt/lists/*