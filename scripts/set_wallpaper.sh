#!/bin/bash

# --- Configurações ---
# Caminho para a pasta dos seus wallpapers (usado se nenhum arquivo for passado como argumento)
WALLPAPER_DIR="$HOME/dotfiles/Wallpapers"

# Nome do seu monitor. Use "*" para aplicar a todos.
# Para descobrir o nome do seu monitor, execute 'hyprctl monitors' no terminal.
MONITOR_NAME="HDMI-A-2" # <--- ALtere para o nome do seu monitor (ex: eDP-1, HDMI-A-1)

# --- Lógica do Script ---
NEW_WALLPAPER=""

# Verifica se um caminho de arquivo foi passado como argumento para o script
if [ -n "$1" ]; then
    NEW_WALLPAPER="$1"
else
    # Se nenhum argumento foi passado, escolhe um wallpaper aleatório da pasta
    if [ -d "$WALLPAPER_DIR" ]; then
        NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)
    else
        echo "Erro: O diretório de wallpapers '$WALLPAPER_DIR' não existe."
        exit 1
    fi
fi

# Verifica se o arquivo de wallpaper existe antes de tentar aplicar
if [ -f "$NEW_WALLPAPER" ]; then
    hyprctl hyprpaper reload "$MONITOR_NAME,$NEW_WALLPAPER"
    echo "Wallpaper alterado para: $NEW_WALLPAPER"
else
    echo "Erro: O arquivo de imagem não foi encontrado ou não é válido: $NEW_WALLPAPER"
    exit 1
fi