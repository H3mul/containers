FROM archlinux:base-devel-20240721.0.248532

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ARG USERNAME=hemul
ARG GH_USER=h3mul

RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm git base-devel && \
    useradd -ms /bin/zsh ${USERNAME} && \
    passwd -d ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) ALL" > /etc/sudoers.d/${USERNAME} && \
    cd "/home/${USERNAME}" && \
    sudo -u ${USERNAME} git clone --depth 1 https://aur.archlinux.org/yay.git && \
    cd yay && \
    sudo -u ${USERNAME} makepkg -si --noconfirm \
    cd .. && \
    rm -rf yay && \
    sudo -u ${USERNAME} yay -S --noconfirm \
      chezmoi \
      code-server \
      docker \
      docker-compose \
      htop \
      openssh \
      supervisor && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -A && \
    sudo -u ${USERNAME} chezmoi init ${GH_USER} --force && \
    sudo -u ${USERNAME} chezmoi update

ENV VS_SERVER_PASSWORD "admin"
ENV VS_SERVER_PORT "8080"
ENV VS_SERVER_USER ${USERNAME}

COPY supervisord.conf /etc/supervisord.conf

WORKDIR  "/home/${USERNAME}"
VOLUME [ "/home/${USERNAME}" ]
CMD [ "/usr/bin/supervisord"]