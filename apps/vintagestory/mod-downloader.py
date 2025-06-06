# From:
# https://github.com/stevewm/homelab/blob/e4d737e66de13f418f900e1039670e5054478046/kubernetes/apps/games/vintagestory/app/config/init/mods.py

import requests
import yaml
import os
import jsonata
import sys

# Constants
MODS_API_BASE_URL = "https://mods.vintagestory.at/api/mod/"
MODS_FILE = os.getenv("MODS_FILE", "/init/mods.yaml")
MODS_DIR = os.getenv("MODS_DIR")

if os.path.isfile(MODS_FILE):
    with open(MODS_FILE, "r") as f:

        mods = yaml.safe_load(f).get("mods", [])
        for mod in mods:
            print(f"Processing mod {mod['id']} ({mod['version']})")

            mod_data = requests.get(f"{MODS_API_BASE_URL}{mod['id']}").json()
            expr = jsonata.Jsonata(f'mod.releases[modversion="{mod["version"]}"].mainfile')
            download_url = expr.evaluate(mod_data)

            if download_url is None:
                print(f"Version {mod['version']} not found for mod {mod['id']}")
                sys.exit(1)

            # Download the mod
            response = requests.get(download_url, stream=True)
            response.raise_for_status()
            filename = (
                response.headers.get("Content-Disposition", "")
                .split("filename=")[-1]
                .strip('"')
                or f"{mod['id']}-{mod['version']}.zip"
            )

            file_path = os.path.join(MODS_DIR, filename)

            with open(file_path, "wb") as f:
                f.write(response.content)
            print(f"Downloaded {mod['id']} to {file_path}")