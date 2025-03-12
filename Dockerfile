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

RUN wget https://gitlab.synchro.net/main/sbbs/-/raw/master/install/install-sbbs.mk
RUN make -f install-sbbs.mk SYMLINK=1 SBBSDIR=/sbbs

VOLUME ["/sbbs"]

EXPOSE 23 513

CMD ["/sbbs/exec/sbbs"]
