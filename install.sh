#!/usr/bin/env bash

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/deivy-ramirez/localhost-cli/main"
INSTALL_DIR="$HOME/bin"
CMD_NAME="localhost"
TARGET="$INSTALL_DIR/$CMD_NAME"

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

echo "Instalando $CMD_NAME en $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"

echo "Descargando $CMD_NAME desde GitHub..."
curl -fsSL "$REPO_RAW/$CMD_NAME" -o "$TARGET"

echo "Asignando permisos..."
chmod +x "$TARGET"

echo "Configurando PATH..."
append_path_if_missing "$HOME/.bashrc"
append_path_if_missing "$HOME/.zshrc"
append_path_if_missing "$HOME/.profile"

# Disponible en esta ejecución del instalador
export PATH="$HOME/bin:$PATH"

echo ""
echo "Recargando configuración del shell..."

# Lo que pediste
if [ -f "$HOME/.bashrc" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.bashrc"
fi

if [ -n "${ZSH_VERSION:-}" ] && [ -f "$HOME/.zshrc" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.zshrc"
fi

hash -r 2>/dev/null || true

echo ""
echo "✅ Instalación completada."
echo ""

if command -v localhost >/dev/null 2>&1; then
  echo "✔ El comando 'localhost' ya está disponible."
else
  echo "⚠️ El comando fue instalado, pero puede que aún no esté disponible en esta sesión."
  echo "Esto puede pasar si instalaste con: curl ... | bash"
  echo ""
  echo "Ejecuta uno de estos comandos:"
  echo "  source ~/.bashrc"
  echo "  hash -r"
  echo ""
  echo "O abre una nueva terminal."
fi

echo ""
echo "Ruta esperada:"
echo "  $TARGET"
echo ""
echo "Prueba:"
echo "  localhost --help"
echo ""
echo "Ejemplo de uso:"
echo "  localhost midominio.com 1.2.3.4"
echo ""
