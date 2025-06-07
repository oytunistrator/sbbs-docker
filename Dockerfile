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

# Download and build Synchronet BBS from source
RUN echo "Downloading and building Synchronet BBS..." && \
    git clone https://gitlab.synchro.net/main/sbbs.git . && \
    ./configure && \
    make && \
    make install && \
    echo "Setting up directories..." && \
    mkdir -p /sbbs/exec && \
    cp ./exec/sbbs /sbbs/exec/ && \
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
CMD echo "Starting Synchronet BBS..." && \
    cd /sbbs && \
    ./exec/sbbs -d
