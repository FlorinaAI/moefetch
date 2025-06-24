#!/usr/bin/env python3
import os
import sys
import time
import configparser
import requests
import subprocess
from pathlib import Path
from datetime import datetime

CONFIG_PATH = Path.home() / ".config" / "moefetch" / "config.ini"
CACHE_DIR = Path.home() / ".cache" / "moefetch"
NEOFETCH_CONFIG_PATH = Path.home() / ".config" / "neofetch" / "config.conf"

def load_config():
    config = configparser.ConfigParser()
    if not CONFIG_PATH.exists():
        print(f"Uh-oh! The config file at {CONFIG_PATH} disappeared like a sneaky little kitten! Let’s bring it back, okay~?💕")
        sys.exit(1)
    config.read(CONFIG_PATH)
    return config

def get_cached_images():
    if not CACHE_DIR.exists():
        return []
    return sorted(CACHE_DIR.glob("image_*.png"), key=lambda f: f.stat().st_mtime, reverse=True)

def cache_valid(cache_duration: int) -> bool:
    cached_images = get_cached_images()
    if not cached_images:
        return False
    newest = cached_images[0]
    age = time.time() - newest.stat().st_mtime
    return age < cache_duration

def cleanup_cache(max_files: int):
    cached_images = get_cached_images()
    if len(cached_images) <= max_files:
        return
    for old_file in cached_images[max_files:]:
        try:
            old_file.unlink()
        except Exception as e:
            print(f"There was a little trouble deleting the cache file: {e}… Let’s gently try again, okay~?")

def fetch_image(api_url: str) -> str:
    try:
        r = requests.get(api_url, timeout=10)
        r.raise_for_status()
        json_data = r.json()
        if "url" in json_data:
            return json_data["url"]
        elif "image" in json_data:
            return json_data["image"]
        else:
            print("Aww~! No image URL found in the API response… Maybe it’s hiding somewhere secret! Let’s look again, nya~!💖")
            sys.exit(1)
    except Exception as e:
        print(f"The API got shy and couldn’t fetch the image: {e}… Let’s cheer it up to try once more!✨")
        sys.exit(1)

def download_image_unique(url: str, cache_dir: Path) -> Path:
    try:
        r = requests.get(url, timeout=10)
        r.raise_for_status()
        cache_dir.mkdir(parents=True, exist_ok=True)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        unique_path = cache_dir / f"image_{timestamp}.png"
        with open(unique_path, "wb") as f:
            f.write(r.content)
        return unique_path
    except Exception as e:
        print(f"Oopsie, something went wrong while downloading the image: {e}… Let’s try again with extra sparkle! ✨(≧◡≦)✨")
        sys.exit(1)

def update_neofetch_config(image_path: Path):
    if not NEOFETCH_CONFIG_PATH.exists():
        print("Uh-oh! The Neofetch config file is playing hide-and-seek and can’t be found! Don’t forget to add it, okay~?")
        print(f'image_source="{image_path}"')
        return

    lines = NEOFETCH_CONFIG_PATH.read_text().splitlines()
    new_lines = []
    replaced = False
    for line in lines:
        if line.strip().startswith("image_source="):
            new_lines.append(f'image_source="{image_path}"')
            replaced = True
        else:
            new_lines.append(line)
    if not replaced:
        new_lines.append(f'image_source="{image_path}"')

    NEOFETCH_CONFIG_PATH.write_text("\n".join(new_lines))

def run_neofetch():
    try:
        subprocess.run(["neofetch"], check=True)
    except FileNotFoundError:
        print("Oh nyo! Neofetch isn’t installed or it’s playing hide-and-seek again! (Please install Neofetch 💞)")
    except subprocess.CalledProcessError:
        print("Eek! Neofetch tripped over a little error while waking up~ Let’s cheer it on to try again! (≧◡≦)♡")

def main():
    config = load_config()
    general = config["general"]
    apis = config["apis"]

    api_name = general.get("api", "waifu.pics")
    category = general.get("category", "waifu")
    cache_duration = int(general.get("cache_duration", "3600"))
    max_cache_files = int(general.get("max_cache_files", "5"))

    if api_name not in apis:
        print(f"Oopsie~! The API named {api_name} is playing hide-and-seek in the config and I just can't find it! (⁄ ⁄>⁄ ▽ ⁄<⁄ ⁄)")
        sys.exit(1)

    api_url_template = apis[api_name]
    api_url = api_url_template.format(category=category)

    if cache_valid(cache_duration):
        cached_images = get_cached_images()
        image_path = cached_images[0]
    else:
        image_url = fetch_image(api_url)
        image_path = download_image_unique(image_url, CACHE_DIR)
        cleanup_cache(max_cache_files)

    update_neofetch_config(image_path)
    run_neofetch()

if __name__ == "__main__":
    main()

