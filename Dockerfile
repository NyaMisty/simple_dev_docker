ARG UBUNTU_VERSION 20.04

FROM jrei/systemd-ubuntu:${UBUNTU_VERSION}

ARG PYENV_ROOT "/opt/pyenv"

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install --no-install-recommends -y \
        # base packages \
        sudo ca-certificates cpio perl locales man less lsb-release openssl \
        # oh-my-zsh dependency \
        wget curl vim git zsh gawk \
        # remote access tools \
        rsync mosh openssh-client \
        # user tool packages \
        screen tmux zip unzip p7zip-full p7zip-rar nmap socat proxychains4 \
        # user tool packages2
        strace net-tools \
        && apt-get clean && rm -rf /var/lib/apt/lists/*;

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install --no-install-recommends -y \
        # base build depends \
        build-essential gcc g++ \
        && apt-get clean && rm -rf /var/lib/apt/lists/*;

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install --no-install-recommends -y \
        # suggested packages \
        libtool gettext flex bison gdb pkg-config \
        # other build tools \
        make autoconf automake fakeroot \
        && apt-get clean && rm -rf /var/lib/apt/lists/*;

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install --no-install-recommends -y \
        # LLVM world \
        cmake ninja-build clang \
        # pyenv dependency \
        make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl \
        libncursesw5-dev xz-utils libxml2-dev libffi-dev liblzma-dev \
        && apt-get clean && rm -rf /var/lib/apt/lists/*;

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/pyenv/pyenv.git /opt/pyenv && cd /opt/pyenv && src/configure && make -C src

RUN export PYENV_ROOT="${PYENV_ROOT:-/opt/pyenv}" && export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init --path)" && eval "$(pyenv init -)" && \
    pyenv install 2.7.13 && pyenv install 3.9.5 && pyenv global 2.7.13 3.9.5 system && \
    pip install requests ipython && \
    pip3 install requests ipython

ADD .zshrc.local /root/.zshrc.local

RUN cd ~ && git clone https://github.com/NyaMisty/.misty_envconf_pub && rm ~/.zshrc && ~/.misty_envconf_pub/install.sh

CMD ["zsh"]