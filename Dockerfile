FROM ubuntu:20.04

# Args to control how the container is built
ARG NEOVIM=0.8.1

# 24bit colour on the terminal
ENV TERM=screen-256color

# Update certs
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    \
    apt-get -y install ca-certificates && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*
#ADD *host.pem /usr/local/share/ca-certificates/host.crt
RUN update-ca-certificates

RUN echo "*** Installing Git ***" && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install git && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Add utils packages
RUN echo "*** Add useful packages ***" && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install wget curl npm lldb fzf ripgrep fd-find unzip && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN echo "*** Install node and yarn ***" && \
    apt-get -y update && \
    apt-get -y install nodejs yarnpkg && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# dotnet support
RUN echo "*** Installing dotnet ***" && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    /bin/bash -c "$(curl -fsSL https://dot.net/v1/dotnet-install.sh)" && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Set up environment
ENV PATH="/root/.dotnet/:/root/.dotnet/tools:/root/.local/bin/:${PATH}"
ENV DOTNET_ROOT="/root/.dotnet/"

# Essential packages to build neovim
RUN echo "*** Neovim Build ***" && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install software-properties-common && \ 
    \
    apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake pkg-config unzip doxygen && \
    \
    curl -LJO https://github.com/neovim/neovim/archive/refs/tags/v$NEOVIM.tar.gz && \
    tar xvf neovim-$NEOVIM.tar.gz && \
    cd neovim-$NEOVIM && \
    make CMAKE_BUILD_TYPE=Release && \
    make install && \
    \
    cd .. && \
    rm -rf neovim-$NEOVIM && \
    rm neovim-$NEOVIM.tar.gz && \
    \
    mkdir -p /root/.config/nvim/lua && \
    \
    apt-get -y remove software-properties-common && \ 
    apt-get -y remove ninja-build gettext libtool libtool-bin autoconf automake cmake pkg-config doxygen && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN echo "*** Getting neotest-dotnet-tests repo ***" && \
    cd /root/ && \
    git clone https://github.com/foldedwave/neotest-dotnet-tests.git dev

RUN echo "*** Getting neotest repo ***" && \
    cd /root/ && \
    git clone https://github.com/foldedwave/neotest.git neotest

RUN echo "*** Getting neotest-dotnet repo ***" && \
    cd /root/ && \
    git clone --single-branch --branch issue27 https://github.com/foldedwave/neotest-dotnet.git neotest-dotnet

WORKDIR /root/dev
CMD ["/bin/bash", "-c", "nvim"]
