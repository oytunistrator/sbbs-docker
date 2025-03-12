# Base image olarak Ubuntu kullanıyoruz
FROM ubuntu:20.04

# Çevresel değişkenleri ayarlayarak tzdata'nın etkileşimli kısmını atlıyoruz
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
    && rm -rf /var/lib/apt/lists/*

# Synchronet BBS kaynağını /opt/synchronet altına klonluyoruz
RUN git clone https://github.com/SynchronetBBS/sbbs.git /opt/synchronet

# Synchronet dizinine gidiyoruz
WORKDIR /opt/synchronet

# Önce eski symlink hatalarını önlemek için exec ve docs dizinlerini temizliyoruz
RUN rm -rf /opt/synchronet/docs /opt/synchronet/exec

# Kaynak kodlarını derliyoruz
RUN make -C /opt/synchronet/src/sbbs3

# Binary dosyalarını erişilebilir hale getirmek için exec klasörünü bağlıyoruz
RUN ln -s /opt/synchronet/repo/exec /opt/synchronet/exec

# Konfigürasyon dosyalarını ve gerekli klasörleri ekleyelim
VOLUME ["/sbbs"]

# Telnet portunu açalım
EXPOSE 23

# Synchronet BBS'yi başlatmak için gerekli komut
CMD ["/opt/synchronet/exec/sbbs"]
