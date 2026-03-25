#!/usr/bin/env bash

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/deivy-ramirez/localhost-cli/main"
INSTALL_DIR="${HOME}/bin"
CMD_NAME="localhost"
TARGET="${INSTALL_DIR}/${CMD_NAME}"

append_path_if_missing() {
  local rcfile="$1"
  local line='export PATH="$HOME/bin:$PATH"'

  [[ -f "$rcfile" ]] || touch "$rcfile"

  if ! grep -Fqs '$HOME/bin:$PATH' "$rcfile"; then
    {
      echo ""
      echo "# Added by localhost installer"
      echo "$line"
    } >> "$rcfile"
  fi
}

echo "Instalando ${CMD_NAME} en ${INSTALL_DIR}..."
mkdir -p "$INSTALL_DIR"

echo "Descargando archivos..."
curl -fsSL "${REPO_RAW}/${CMD_NAME}" -o "$TARGET"

chmod +x "$TARGET"

echo "Configurando PATH..."

append_path_if_missing "${HOME}/.bashrc"
append_path_if_missing "${HOME}/.zshrc"
append_path_if_missing "${HOME}/.profile"

# Export inmediato para esta sesión
export PATH="$HOME/bin:$PATH"

echo ""
echo "Recargando configuración de la terminal..."

# 🔥 Aquí está lo que pediste
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

# Fallback para zsh
if [ -n "${ZSH_VERSION:-}" ] && [ -f "$HOME/.zshrc" ]; then
  source "$HOME/.zshrc"
fi

echo ""
echo "✅ Instalación completada correctamente."
echo ""
echo "Puedes usar el comando:"
echo "  localhost --help"
echo ""
echo "Ejemplo:"
echo "  localhost midominio.com 1.2.3.4"
echo ""
