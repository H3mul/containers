# From:
# https://github.com/cocktailpeanut/fluxgym/blob/93c801d01b69f935cf29948a46000b26d0734024/Dockerfile

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

# Base image with CUDA 12.2
FROM nvidia/cuda:12.2.2-base-ubuntu22.04@sha256:1a8a738e81d4adbef0c709241f5238cec5bb77186dcb5b2103db293315ed42d1

# Install pip if not already installed
RUN apt-get update -y && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    python3-pip \
    python3-dev \
    openssh-server \
    git \
    build-essential \
    curl \
    supervisor  # Install dependencies for building extensions

RUN rm -f /etc/ssh/ssh_host_*
RUN pip install --upgrade uv

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    code-server --install-extension enkia.tokyo-night \
                --install-extension ms-python.python

ENV GRADIO_SERVER_NAME="0.0.0.0"
ENV CODE_SERVER_PASSWORD="admin"
ENV CODE_SERVER_PORT="8080"

WORKDIR /app

RUN git clone https://github.com/cocktailpeanut/fluxgym.git
WORKDIR /app/fluxgym

RUN [ -z "${VERSION}" ] || git checkout "${VERSION}"

RUN uv pip install --system --no-cache-dir -r ./requirements.txt

# Get sd-scripts from kohya-ss and install them
RUN git clone -b sd3 https://github.com/kohya-ss/sd-scripts && \
    cd sd-scripts && \
    uv pip install --system --no-cache-dir -r ./requirements.txt

# Install Torch, Torchvision, and Torchaudio for CUDA 12.2
RUN uv pip install --system torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu122/torch_stable.html

COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7860 8080

# Run fluxgym Python application
CMD [ "/entrypoint.sh"]