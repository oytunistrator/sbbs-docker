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

RUN addgroup --gid 1000 sbbs \
    && adduser --disabled-password --shell /bin/bash --uid 1000 --gid 1000 --gecos '' sbbs \
    && adduser sbbs sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN git clone --depth=1 https://github.com/SynchronetBBS/sbbs.git /opt/synchronet

WORKDIR /opt/synchronet

RUN cd ./install \
    && sed -i.bak '/git/d' ./GNUmakefile \
    && make RELEASE=1 NO_X=1 SBBSDIR=/sbbs install
RUN cd ./src/sbbs3 \
    && make RELEASE=1 NO_X=1 SBBSDIR=/sbbs install

FROM base AS runtime
COPY --from=build /sbbs /sbbs
WORKDIR /sbbs
USER sbbs
VOLUME ["/sbbs"]

EXPOSE 23 513

CMD ["/sbbs/exec/sbbs"]
