FROM nvidia/cuda:12.2.2-base-ubuntu22.04@sha256:1a8a738e81d4adbef0c709241f5238cec5bb77186dcb5b2103db293315ed42d1

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        ninja-build \
        openssh-server \
        python3 \
        python3-pip \
        wget \
        rsync \
        supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt

RUN rm -f /etc/ssh/ssh_host_* && mkdir -p -m 0755 /run/sshd

# Install Python packages globally
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel uv

# Setup ComfyUI in /opt (read-only application directory)
ARG VERSION
RUN set -xe && \
    git clone https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui && \
    cd /opt/comfyui && \
    git fetch --all --tags && \
    git checkout ${VERSION} && \
    uv pip install --system --no-cache-dir -r requirements.txt && \
    uv pip install --system --no-cache-dir comfy-cli && \
    (echo "N" | comfy tracking disable 2>/dev/null || true) && \
    (comfy --install-completion 2>/dev/null || true) && \
    (comfy node install --mode remote ComfyUI-Crystools ComfyUI-Custom-Scripts 2>/dev/null || \
        echo "Note: Some custom nodes could not be installed automatically")

RUN uv pip install --system torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu129

# Setup ComfyUI Manager
ARG UI_MANAGER_VERSION=main
RUN set -xe && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /opt/comfyui/custom_nodes/ComfyUI-Manager && \
    cd /opt/comfyui/custom_nodes/ComfyUI-Manager && \
    git fetch --all --tags && \
    git checkout ${UI_MANAGER_VERSION} && \
    uv pip install --system --no-cache-dir -r requirements.txt

# Environment variables
ENV \
    NVIDIA_DRIVER_CAPABILITIES=all \
    PATH="/usr/local/bin:/data/user/.local/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    VERSION="${VERSION}" \
    COMFYUI_PATH="/opt/comfyui" \
    DATA_PATH="/workspace/comfyui" \
    PUBLIC_KEY=""

# Switch to non-root user

# Expose HTTP port
EXPOSE 8188

COPY supervisord.conf /etc/supervisord.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
