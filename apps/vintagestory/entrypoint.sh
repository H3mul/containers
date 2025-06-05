#!/usr/bin/env sh

set -eu

mkdir -p "$MODS_DIR"
echo "Downloading mods, if any..."
python3 /init/mod-downloader.py

echo "Starting game server..."
dotnet /game/VintagestoryServer.dll --dataPath $VS_DATA_PATH
