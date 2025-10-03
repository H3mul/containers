ARG BASE_IMAGE=nvidia/cuda:12.6.3-devel-ubuntu22.04
FROM ${BASE_IMAGE} AS base

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        bash-completion \
        build-essential \
        cmake \
        curl \
        git \
        iproute2 \
        libbz2-dev \
        libegl1 \
        libgl1 \
        libgl1-mesa-dev \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libglu1-mesa-dev \
        libglvnd-dev \
        libglx0 \
        libopencv-dev \
        libopengl0 \
        libx11-dev \
        libxcursor-dev \
        libxi-dev \
        libxinerama-dev \
        libxrandr-dev \
        mesa-common-dev \
        mesa-utils \
        ninja-build \
        openssh-server \
        pkg-config \
        python-is-python3 \
        python3 \
        python3-dev \
        python3-opencv \
        python3-pip \
        python3-psutil \
        rsync \
        software-properties-common \
        unzip \
        vim \
        wget \
        xauth \
        xvfb && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        libavcodec-dev \
        libavdevice-dev \
        libavfilter-dev \
        libavformat-dev \
        libavutil-dev \
        libswresample-dev \
        libswscale-dev \
        python3-av && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN rm -f /etc/ssh/ssh_host_*
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python packages globally
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel

# Setup ComfyUI in /opt (read-only application directory)
ARG VERSION
RUN set -xe && \
    git clone https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui && \
    cd /opt/comfyui && \
    git fetch --all --tags && \
    git checkout ${VERSION} && \
    pip3 install --no-cache-dir -r requirements.txt && \
    pip3 install --no-cache-dir comfy-cli && \
    (echo "N" | comfy tracking disable 2>/dev/null || true) && \
    (comfy --install-completion 2>/dev/null || true) && \
    (comfy node install --mode remote ComfyUI-Crystools ComfyUI-Custom-Scripts 2>/dev/null || \
        echo "Note: Some custom nodes could not be installed automatically")

# Setup ComfyUI Manager
ARG UI_MANAGER_VERSION=main
RUN set -xe && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /opt/comfyui/custom_nodes/ComfyUI-Manager && \
    cd /opt/comfyui/custom_nodes/ComfyUI-Manager && \
    git fetch --all --tags && \
    git checkout ${UI_MANAGER_VERSION} && \
    pip3 install --no-cache-dir -r requirements.txt

# Create directories and copy entrypoint
ARG BUILD_DATE

# Environment variables
ENV \
    NVIDIA_DRIVER_CAPABILITIES=all \
    PATH="/usr/local/bin:/data/user/.local/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    VERSION="${VERSION}" \
    COMFYUI_PATH="/opt/comfyui" \
    DATA_PATH="/data"

# Switch to non-root user

# Expose HTTP port
EXPOSE 8188

# Volumes for data persistence
VOLUME /data
WORKDIR /data/user

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
