#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="${1:-imt-211}"
MINICONDA_DIR="$HOME/miniconda3"

section () { echo -e "\n=== $1 ==="; }

# Detectar conda
if ! command -v conda >/dev/null 2>&1; then
  section "Conda no encontrado. Instalando Miniconda (usuario)"
  TMP_DIR="$(mktemp -d)"
  pushd "$TMP_DIR" >/dev/null
  INST="Miniconda3-latest-Linux-x86_64.sh"
  URL="https://repo.anaconda.com/miniconda/${INST}"
  wget -q "$URL" -O "$INST"
  bash "$INST" -b -p "$MINICONDA_DIR"
  popd >/dev/null
  rm -rf "$TMP_DIR"
  # Inicializar conda para bash
  eval "$("$MINICONDA_DIR/bin/conda" shell.bash hook)"
  conda init bash
else
  # Cargar conda en la shell actual
  eval "$(conda shell.bash hook)"
fi

# Asegurar canales y prioridad
conda config --add channels conda-forge || true
conda config --add channels defaults || true
conda config --set channel_priority flexible

# Crear/actualizar entorno
if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  section "Actualizando entorno '$ENV_NAME'"
  conda env update -n "$ENV_NAME" -f environment.yml --prune
else
  section "Creando entorno '$ENV_NAME'"
  conda env create -f environment.yml
fi

section "Activando entorno"
conda activate "$ENV_NAME"

section "Listo. Ejecuta './scripts/ubuntu/launch_jupyter.sh' para iniciar JupyterLab."