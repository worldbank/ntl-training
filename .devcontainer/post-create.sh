#!/usr/bin/env bash
# Runs once after the Codespace container is created.
# Uses uv to create .venv and install all dependencies from pyproject.toml + uv.lock.

set -euo pipefail

echo ">>> Syncing dependencies with uv (creates .venv and installs from uv.lock)"
uv sync

echo ">>> Installing ipykernel (required for VS Code Jupyter)"
uv pip install ipykernel

echo ">>> Done. Open a notebook and VS Code should auto-select the .venv interpreter."