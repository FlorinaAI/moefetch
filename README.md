# 🌸 Moefetch

**Moefetch** is a cute little extension that turns your terminal into something more... _moe_~  
It works with **Neofetch**, displays a random image on every launch (or from cache) for more moe!

> Terminal should be more moe~ (｡♥‿♥｡)

![Moefetch Example 1](https://i.imgur.com/FJtBDfN.png)
![Moefetch Example 2](https://i.imgur.com/dPwFEKt.png)

---

## ✨ Features

- 🎀 Fetches images from **[waifu.pics](https://waifu.pics)** or **[nekos.life](https://nekos.life)** API (If you want adding yours, you can add)
- 📸 Cached images saved in `~/.cache/moefetch` to reduce API spam
- ⏳ Configurable cache duration and number of cached images
- 🖼️ Works with `neofetch`'s image support (e.g. `kitty`, `w3m`, `chafa`, etc. default is kitty, but you can change)
- 🌸 Custom `neofetch` config (you can use your own, recommended crop_mode="fill")

---

## 📦 Requirements

- Python 3
- `requests` Python package (There is a venv in install script)
- A working **Neofetch** installation with image backend support (e.g., `kitty`, `w3m-img`, `chafa`)

---

## 🔧 Installation

```bash
git clone https://github.com/FlorinaAI/moefetch.git
cd moefetch
chmod +x install.sh
./install.sh
```

## 🗑️ Uninstallation
```bash
git clone https://github.com/FlorinaAI/moefetch.git
cd moefetch
chmod +x uninstall.sh
./uninstall.sh
```

---

## ❄️ Usage
```bash
moefetch
```

---

## 🍦 Configuration
`~/.config/moefetch/config.ini:`
```bash
[general]
# API type [apis] ⬇️⬇️⬇️
api = waifu.pics

# For category info, please visit the API pages!
#
# waifu.pics: https://waifu.pics/docs
# nekos.life: https://nekos.life/api/v2/endpoints
category = waifu

# Cache duration in seconds! If you don’t know, it means how often the image will change hehe~
cache_duration = 10

# This one decides how many images can hang out in the .cache folder at once. Let’s keep it cozy but not too crowded! Nuh uh!
max_cache_files = 5
    
[apis]
# Yay!!! Here are the API details! Feel free to add your own too if you want~ (Don't use nsfw please)
waifu.pics = https://api.waifu.pics/sfw/{category}
waifu.pics-nsfw = https://api.waifu.pics/nsfw/{category}
nekos.life = https://nekos.life/api/v2/img/{category}
```

---

## 🧁 Credits

- 💻 **[Neofetch](https://github.com/dylanaraps/neofetch)** – The powerful and flexible system information tool that Moefetch decorates.
- 🌸 **[waifu.pics](https://waifu.pics/)** – For the anime images.
- 🐾 **[nekos.life](https://nekos.life/)** – Another adorable API for anime images.


> ʕっ•ᴥ•ʔっ Terminal should be more _moe_~   💖


