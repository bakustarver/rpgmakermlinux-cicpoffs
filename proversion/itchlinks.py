#!/usr/bin/env python3
import sys
import os
import requests
from bs4 import BeautifulSoup
import re
from typing import Optional

ITCH_API = "https://api.itch.io"
ITCH_GAME_URL_REGEX = r"^https:\/\/(?P<author>[\w\d\-_]+).itch.io\/(?P<game>[\w\d\-_]+)$"

def get_api_key() -> Optional[str]:
    """Check env var ITCH_API_KEY or ~/.config/itchiokey.txt"""
    # 1. Environment variable
    api_key = os.environ.get("ITCH_API_KEY")
    if api_key:
        return api_key.strip()

    # 2. Config file
    home = os.path.expanduser("~")
    key_file = os.path.join(home, ".config", "itchiokey.txt")
    if os.path.isfile(key_file):
        with open(key_file) as f:
            return f.read().strip()

    return None

def get_game_id(url: str) -> int:
    """Extract game ID from itch.io page or data.json."""
    r = requests.get(url)
    r.raise_for_status()
    site = BeautifulSoup(r.text, "lxml")

    meta = site.find("meta", attrs={"name": "itch:path"})
    if meta:
        return int(meta["content"].split("/")[-1])

    data_url = url.rstrip("/") + "/data.json"
    r = requests.get(data_url)
    r.raise_for_status()
    data = r.json()
    return int(data["id"])

def get_linux_uploads(game_id: int, api_key: str) -> list[tuple[str, str]]:
    """Return (filename, download_url) for Linux builds."""
    url = f"{ITCH_API}/games/{game_id}/uploads"
    r = requests.get(url, params={"api_key": api_key}, timeout=15)
    r.raise_for_status()
    uploads = r.json()["uploads"]

    linux_uploads = []
    for up in uploads:
        traits = up.get("traits", [])
        if "p_linux" in traits:
            filename = up.get("filename", f"upload_{up['id']}")
            dl_url = f"{ITCH_API}/uploads/{up['id']}/download?api_key={api_key}"
            linux_uploads.append((filename, dl_url))
    return linux_uploads

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <itch.io link>")
        sys.exit(1)

    itch_url = sys.argv[1]
    api_key = get_api_key()
    if not api_key:
        print("No API key found. Please set $ITCH_API_KEY or ~/.config/itchiokey.txt")
        sys.exit(1)

    if not re.match(ITCH_GAME_URL_REGEX, itch_url):
        print("Invalid itch.io game URL")
        sys.exit(1)

    try:
        game_id = get_game_id(itch_url)
        uploads = get_linux_uploads(game_id, api_key)
        if uploads:
            print("Linux builds found:")
            for filename, link in uploads:
                print(f"{filename} -> {link}")
        else:
            print("No Linux builds available for this game.")
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
