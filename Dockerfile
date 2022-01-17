FROM ubuntu:20.04

ARG PYENV_ROOT "/opt/pyenv"

RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
        # base packages \
        binutils busybox-initramfs ca-certificates cpio perl locales man gpg less lsb-release openssl tcl tcl-dev \
        ;

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
        # build dependencies \
        make autoconf automake cmake gcc clang build-essential dpkg-dev fakeroot \
        # pyenv dependency \
        make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
        ;


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
        # oh-my-zsh dependency \
        wget curl vim git zsh gawk \
        # remote access tools \
        rsync mosh openssh-client openssh-server \
        # user tool packages \
        screen tmux unzip p7zip-full nmap socat \
        ;

RUN git clone https://github.com/pyenv/pyenv.git /opt/pyenv && cd /opt/pyenv && src/configure && make -C src

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN export PYENV_ROOT="${PYENV_ROOT:-/opt/pyenv}" && export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init --path)" && eval "$(pyenv init -)" && \
    pyenv install 2.7.13 && pyenv install 3.9.5 && pyenv global 2.7.13 3.9.5 system

ADD .zshrc.local /root/.zshrc.local

RUN cd ~ && git clone https://github.com/NyaMisty/.misty_envconf_pub && rm ~/.zshrc && ~/.misty_envconf_pub/install.sh

CMD ["zsh"]