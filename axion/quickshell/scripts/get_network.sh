#!/bin/bash
# Verifica se há conexão WiFi ativa. Retorna ícones diferentes baseado no status.
status=$(cat /sys/class/net/wl*/operstate 2>/dev/null | head -n 1)

if [ "$status" = "up" ]; then
    echo "󰤨"
else
    echo "󰤭"
fi
