FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    git \
    wget \
    libssl-dev \
    libboost-all-dev \
    libsqlite3-dev \
    zlib1g-dev \
    libevent-dev \
    libpcap-dev \
    libc6-dev \
    gcc \
    g++ \
    make \
    libarchive-dev \
    libncurses5-dev \
    pkg-config \
    unzip \
    patch \
    perl \
    python3 \
    zip \
    sudo \
    libnspr4-dev \
    libnss3-dev \
    libcap2-bin \
    libjson-c-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/synchronet

# Download and install Synchronet BBS with detailed logging
RUN echo "Downloading install script..." && \
    wget -O install-sbbs.mk https://gitlab.synchro.net/main/sbbs/-/raw/master/install/install-sbbs.mk && \
    echo "Installing Synchronet BBS..." && \
    make -f install-sbbs.mk SYMLINK=1 SBBSDIR=/sbbs && \
    echo "Setting permissions..." && \
    chmod +x /sbbs/exec/sbbs && \
    echo "Installation complete. Verifying..." && \
    ls -l /sbbs/exec/sbbs && \
    echo "Directory structure:" && \
    ls -la /sbbs

# Verify installation with detailed output
RUN echo "Final verification:" && \
    ls -la /sbbs/exec && \
    echo "Executable permissions:" && \
    stat -c "%a %n" /sbbs/exec/sbbs

VOLUME ["/sbbs"]

EXPOSE 23 513

# Start Synchronet BBS with detailed logging
CMD echo "Starting Synchronet BBS..." && /sbbs/exec/sbbs -d
