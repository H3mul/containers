FROM archlinux:base-devel-20240721.0.248532

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ARG USERNAME "hemul"
ARG CHEZMOI_GH_USER "h3mul"
ARG USER_SHELL "/bin/zsh"

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
    /usr/bin/ssh-keygen -A && \
    setcap cap_net_raw+p /usr/bin/ping && \
    useradd -G sudo -s ${USER_SHELL} -m "${USERNAME}" && \
    passwd -d "${USERNAME}" && \
    sudo -u "${USERNAME}" chezmoi init ${CHEZMOI_GH_USER} --force && \
    sudo -u "${USERNAME}" chezmoi update

ENV VS_SERVER_PASSWORD "admin"
ENV VS_SERVER_PORT "8080"
ENV VS_SERVER_USER ""

COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh"]