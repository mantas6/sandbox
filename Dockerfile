FROM archlinux

RUN sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf; \
    sed -i 's/^#Color/Color/;s/NoProgressBar//' /etc/pacman.conf

RUN pacman-key --init

# Install packages
RUN pacman --noconfirm -Syu

RUN pacman --noconfirm -S \
    sudo \
    git \
    stow \
    neovim \
    man-db

# Set a passwordless sudoer user
RUN useradd -m -G wheel -s /bin/bash sandbox && \
    mkdir -p /etc/sudoers.d/ && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nopasswd

WORKDIR /home/sandbox
USER sandbox

# User environment
ENV TERM=xterm-256color

CMD ["bash"]
