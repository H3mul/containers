FROM archlinux:base-devel-20240721.0.248532@sha256:21c96d7f815d65b5d7e87be20020bada9c60f2a7ad1a4157e8f0fa7526c755c7

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ARG USERNAME="hemul"
ARG CHEZMOI_GH_USER="h3mul"
ARG USER_SHELL="/bin/zsh"

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
      rsync \
      openssh \
      supervisor && \
    rm -rf /etc/sudoers.d/yay && \
    sed -i 's/#PubkeyAuthentication.*$/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#AllowAgentForwarding.*$/AllowAgentForwarding yes/g' /etc/ssh/sshd_config && \
    echo "StreamLocalBindUnlink yes" >> /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -A && \
    setcap cap_net_raw+p /usr/bin/ping && \
    useradd -G sudo -s ${USER_SHELL} -m "${USERNAME}" && \
    passwd -d "${USERNAME}" && \
    sudo -u "${USERNAME}" chezmoi init ${CHEZMOI_GH_USER} --force && \
    sudo -u "${USERNAME}" chezmoi update && \
    rm -rf /home/"${USERNAME}" # Home dir is meant to be mounted

ENV VS_SERVER_PASSWORD "admin"
ENV VS_SERVER_PORT "8080"
ENV VS_SERVER_USER ""

COPY supervisord.conf /etc/supervisord.conf
COPY xdg.sh /etc/profile.d/xdg.sh
COPY entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh"]