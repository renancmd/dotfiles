#!/bin/bash
# Detecta o tipo de conexão de rede ativa (Wi-Fi ou cabo) e retorna o ícone
# apropriado, incluindo o estado de acesso à internet quando conectado via cabo.

ICON_WIFI="󰤨"
ICON_ETHERNET="󰈀"
ICON_ETHERNET_NO_INTERNET="󰞗"
ICON_DISCONNECTED="󰤭"

has_internet() {
    ping -c 1 -W 1 1.1.1.1 >/dev/null 2>&1
}

default_iface=$(ip route show default 2>/dev/null | awk '{print $5; exit}')

if [ -n "$default_iface" ]; then
    if [[ "$default_iface" == wl* ]]; then
        echo "$ICON_WIFI"
    else
        if has_internet; then
            echo "$ICON_ETHERNET"
        else
            echo "$ICON_ETHERNET_NO_INTERNET"
        fi
    fi
else
    eth_up=$(cat /sys/class/net/en*/operstate /sys/class/net/eth*/operstate 2>/dev/null | grep -m1 up)
    if [ -n "$eth_up" ]; then
        echo "$ICON_ETHERNET_NO_INTERNET"
    else
        echo "$ICON_DISCONNECTED"
    fi
fi
