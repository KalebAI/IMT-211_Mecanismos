#!/usr/bin/env bash
set -euo pipefail
ENV_NAME="${1:-imt-211}"

# Cargar conda
if command -v conda >/dev/null 2>&1; then
  eval "$(conda shell.bash hook)"
else
  if [ -f "$HOME/miniconda3/bin/conda" ]; then
    eval "$("$HOME/miniconda3/bin/conda" shell.bash hook)"
  else
    echo "No se encontró conda. Ejecuta primero scripts/ubuntu/setup_env.sh"
    exit 1
  fi
fi

conda activate "$ENV_NAME"
jupyter lab