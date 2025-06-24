#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOCAL_BIN="$HOME/.local/bin"
USR_BIN="/usr/bin"

MOEFETCH_LOCAL_PATH="$LOCAL_BIN/moefetch.py"
MOEFETCH_WRAPPER_PATH="$USR_BIN/moefetch"

MOEFETCH_CONFIG_DIR="$HOME/.config/moefetch"
NEOFETCH_CONFIG_PATH="$HOME/.config/neofetch/config.conf"
MOEFETCH_CONFIG_PATH="$MOEFETCH_CONFIG_DIR/config.ini"
MOEFETCH_VENV_PATH="$MOEFETCH_CONFIG_DIR/venv"

echo "==== Uninstalling Moefetch~ Let's clean up with sparkles! ✨ ===="

# Remove wrapper from /usr/bin
if [ -f "$MOEFETCH_WRAPPER_PATH" ]; then
    echo "→ Removing wrapper at $MOEFETCH_WRAPPER_PATH..."
    sudo rm "$MOEFETCH_WRAPPER_PATH"
    echo "✓ Wrapper removed!"
else
    echo "✓ Wrapper at $MOEFETCH_WRAPPER_PATH not found~ maybe it already flew away! ✨"
fi

# Remove script from ~/.local/bin
if [ -f "$MOEFETCH_LOCAL_PATH" ]; then
    echo "→ Removing moefetch script at $MOEFETCH_LOCAL_PATH..."
    rm "$MOEFETCH_LOCAL_PATH"
    echo "✓ Script removed!"
else
    echo "✓ Script file at $MOEFETCH_LOCAL_PATH is already gone~ poof! 💨"
fi

# Remove venv folder (always)
if [ -d "$MOEFETCH_VENV_PATH" ]; then
    echo "→ Removing virtual environment at $MOEFETCH_VENV_PATH..."
    rm -rf "$MOEFETCH_VENV_PATH"
    echo "✓ Virtual environment removed!"
else
    echo "✓ Virtual environment folder not found, maybe already removed~ ✨"
fi

# Ask to remove moefetch config file
if [ -f "$MOEFETCH_CONFIG_PATH" ]; then
    read -p "→ Would you like to remove the moefetch config file at $MOEFETCH_CONFIG_PATH? (y/n): " ans_moefetch_cfg
    if [[ "$ans_moefetch_cfg" =~ ^[Yy]$ ]]; then
        rm "$MOEFETCH_CONFIG_PATH"
        echo "✓ Moefetch config removed!"
    else
        echo "✗ Kept the moefetch config~"
    fi
else
    echo "✓ Moefetch config file not found, no need to remove."
fi

# Ask to remove neofetch config file
if [ -f "$NEOFETCH_CONFIG_PATH" ]; then
    read -p "→ Would you like to remove the neofetch config file at $NEOFETCH_CONFIG_PATH? (y/n): " ans_neofetch_cfg
    if [[ "$ans_neofetch_cfg" =~ ^[Yy]$ ]]; then
        rm "$NEOFETCH_CONFIG_PATH"
        echo "✓ Neofetch config removed!"
    else
        echo "✗ Kept the neofetch config~"
    fi
else
    echo "✓ Neofetch config file not found, no need to remove."
fi

# If config directory empty after deletions, remove it
if [ -d "$MOEFETCH_CONFIG_DIR" ] && [ -z "$(ls -A "$MOEFETCH_CONFIG_DIR")" ]; then
    echo "→ Removing empty moefetch config directory at $MOEFETCH_CONFIG_DIR..."
    rmdir "$MOEFETCH_CONFIG_DIR"
    echo "✓ Moefetch config directory removed!"
fi

echo "✓ Moefetch has been fully uninstalled~ See you next time! (≧▽≦)ゞ"

