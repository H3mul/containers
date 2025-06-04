# Based on:
# https://github.com/Devidian/docker-vintagestory/blob/709b9c0070bdda41f391516937aeffcd66d574f7/Dockerfile

FROM mcr.microsoft.com/dotnet/runtime:7.0@sha256:8cd26108e7a329458e5b84342816ae39b2b38bd041cfdc0b79b8cf1c0e0d376f

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ARG vs_type=stable
ARG vs_version=${VERSION}

# Todo: implement ${TARGETPLATFORM}
ARG vs_os=linux-x64

ENV VS_DATA_PATH=/data
ENV MODS_DIR=${VS_DATA_PATH}/Mods
ENV MODS_FILE=/init/mods.yaml

WORKDIR /game

RUN apt update && apt install tar wget python3-pip -y && \
    pip install --upgrade uv && \
    wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_os}_${vs_version}.tar.gz" && \
    tar -xzvf "vs_server_${vs_os}_${vs_version}.tar.gz" && \
    rm "vs_server_${vs_os}_${vs_version}.tar.gz"

COPY entrypoint.sh /entrypoint.sh
COPY mod-downloader.py /init/mod-downloader.py

EXPOSE 42420

VOLUME ["${VS_DATA_PATH}"]

CMD ["/entrypoint.sh"]
