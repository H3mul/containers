FROM archlinux:base-devel-20240721.0.248532

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm git base-devel sudo && \
    useradd -m yay && \
    passwd -d yay && \
    echo "yay ALL=(ALL) ALL" > /etc/sudoers.d/yay && \
    groupadd sudo && \
    echo "%sudo ALL=(ALL) ALL" > /etc/sudoers.d/sudo && \
    cd /home/yay && \
    sudo -u yay git clone --depth 1 https://aur.archlinux.org/yay.git && \
    cd yay && \
    sudo -u yay makepkg -si --noconfirm && \
    sudo -u yay yay -S --noconfirm \
      zsh \
      chezmoi \
      code-server \
      docker \
      docker-compose \
      htop \
      openssh \
      supervisor && \
    rm -rf /etc/sudoers.d/yay && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -A

ENV USERNAME "hemul"
ENV VS_SERVER_PASSWORD "admin"
ENV VS_SERVER_PORT "8080"
ENV VS_SERVER_USER ${USERNAME}

COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh"]