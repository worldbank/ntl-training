FROM python:3.13

# git is required so uv can resolve the attaviz git+https dependency.
RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Install uv (fast Python package manager) — pulled from the official image
# as a prebuilt binary, much faster than `pip install uv`.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /workspace