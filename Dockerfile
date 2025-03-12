# Ubuntu 20.04 tabanlı image kullanıyoruz
FROM ubuntu:20.04

# Etkileşimli kurulumları engellemek için noninteractive moda geçiyoruz
ENV DEBIAN_FRONTEND=noninteractive

# Gerekli bağımlılıkları yükleyelim
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

# Synchronet kaynak kodunu klonlayalım
RUN git clone --depth=1 https://github.com/SynchronetBBS/sbbs.git /opt/synchronet

# Çalışma dizinini değiştirelim
WORKDIR /opt/synchronet

# Kaynak kodları derleniyor (Resmi dökümantasyona uygun)
RUN make install SYMLINK=1

# Konfigürasyon dosyalarını ve gerekli klasörleri ekleyelim
VOLUME ["/sbbs"]

# Telnet portlarını açalım
EXPOSE 23 513

# Synchronet BBS başlatma komutu
CMD ["/sbbs/exec/sbbs"]
