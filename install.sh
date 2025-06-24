#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VENV_SRC="$BASE_DIR/venv"
MOEFETCH_PY_PATH="$BASE_DIR/moefetch.py"

LOCAL_BIN="$HOME/.local/bin"
USR_BIN="/usr/bin"
MOEFETCH_LOCAL_PATH="$LOCAL_BIN/moefetch.py"
MOEFETCH_WRAPPER_PATH="$USR_BIN/moefetch"

# Config file sources ✨
NEOFETCH_CONFIG_SRC="$BASE_DIR/example neofetch config/config.conf"
MOEFETCH_CONFIG_SRC="$BASE_DIR/example moefetch config/config.ini"

# Config file destinations 🌸
NEOFETCH_CONFIG_DEST="$HOME/.config/neofetch/config.conf"
MOEFETCH_CONFIG_DEST="$HOME/.config/moefetch/config.ini"
MOEFETCH_CONFIG_DIR="$HOME/.config/moefetch"
VENV_DEST="$MOEFETCH_CONFIG_DIR/venv"

# ==== Checks before the magic begins~ 💫 ====
if [ ! -d "$VENV_SRC" ]; then
    echo "✗ Eep! Virtual environment folder not found: $VENV_SRC (｡•́︿•̀｡)"
    exit 1
fi

if [ ! -f "$MOEFETCH_PY_PATH" ]; then
    echo "✗ Oopsie~! Script file is missing: $MOEFETCH_PY_PATH (╯︵╰,)"
    exit 1
fi

# ==== Preparing your terminal magic~ 🪄 ====
mkdir -p "$LOCAL_BIN"
cp "$MOEFETCH_PY_PATH" "$MOEFETCH_LOCAL_PATH"
chmod +x "$MOEFETCH_LOCAL_PATH"

# ==== Copy venv into config folder 🌸 ====
mkdir -p "$VENV_DEST"
cp -r "$VENV_SRC/" "$VENV_DEST/../"
echo "✓ Virtual environment copied into config folder~ nya! → $VENV_DEST"

# ==== Creating the moefetch launcher~ nya! 🐾 ====
echo "#!/bin/bash
\"$VENV_DEST/bin/python\" \"$MOEFETCH_LOCAL_PATH\" \"\$@\"" > /tmp/moefetch_wrapper.sh
chmod +x /tmp/moefetch_wrapper.sh

echo "→ Installing the moefetch wrapper to /usr/bin... please wait~ 💕"
sudo mv /tmp/moefetch_wrapper.sh "$MOEFETCH_WRAPPER_PATH"
if [ $? -ne 0 ]; then
    echo "✗ Oh noes~! Failed to install the wrapper! Please check your sudo powers~ (；´Д｀)"
    exit 1
fi

echo "✓ All done~! You can now use the 'moefetch' command in your terminal! (≧▽≦)ゞ"

# ==== Neofetch config copy prompt 🌼 ====
if [ -f "$NEOFETCH_CONFIG_SRC" ]; then
    read -p "→ Would you like to install the example Neofetch config? (y/n): " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        mkdir -p "$(dirname "$NEOFETCH_CONFIG_DEST")"
        cp "$NEOFETCH_CONFIG_SRC" "$NEOFETCH_CONFIG_DEST"
        echo "✓ Neofetch config copied successfully! ✨ → $NEOFETCH_CONFIG_DEST"
    else
        echo "✗ Okay~ Skipped Neofetch config setup! (｡•̀ᴗ-)✧"
    fi
else
    echo "✗ Oops~ Example Neofetch config not found: $NEOFETCH_CONFIG_SRC (´・ω・｀)"
fi

# ==== Moefetch config copy prompt 🎀 ====
mkdir -p "$MOEFETCH_CONFIG_DIR"
if [ -f "$MOEFETCH_CONFIG_SRC" ]; then
    cp "$MOEFETCH_CONFIG_SRC" "$MOEFETCH_CONFIG_DEST"
    echo "✓ Moefetch config is all set~! ♡ → $MOEFETCH_CONFIG_DEST"
else
    echo "✗ Uwah~ Couldn't find the example Moefetch config: $MOEFETCH_CONFIG_SRC"
fi

