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
      code-server \
      chezmoi && \
    sudo -u ${USERNAME} chezmoi init $GH_USER

WORKDIR  "/home/${USERNAME}"
VOLUME [ "/home/${USERNAME}" ]

# gpg keys
# git ssh keys
# chezmoi dotfiles
# code server
# utils

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
