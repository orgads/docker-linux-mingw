FROM debian:testing
RUN printf 'APT::Get::Install-Recommends "false";\nAPT::Get::Install-Suggests "false";' > /etc/apt/apt.conf.d/10no-recommends
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    autoconf \
    automake \
    autopoint \
    bash \
    bison \
    bzip2 \
    ccache \
    cmake \
    curl \
    flex \
    g++ \
    gettext \
    git \
    gperf \
    intltool \
    less \
    libffi-dev \
    libgdk-pixbuf2.0-dev \
    libltdl-dev \
    libssl-dev \
    libtool \
    libtool-bin \
    libxml-parser-perl \
    lld \
    lzip \
    make \
    openssl \
    p7zip-full \
    patch \
    perl \
    pkg-config \
    python-is-python3 \
    ruby \
    sed \
    unzip \
    vim \
    wget \
    xz-utils \
    && apt-get clean

ENV PATH=$PATH:/opt/mxe/usr/bin

RUN git clone https://github.com/orgads/mxe /opt/mxe
RUN cd /opt/mxe && \
    make -j$(nproc) JOBS=$(nproc) \
    boost \
    gcc \
    libgnurx \
    lld \
    mingw-w64 \
    zlib \
    MXE_TARGETS=i686-w64-mingw32.static \
    MXE_PLUGIN_DIRS=plugins/gcc12 \
    MXE_USE_CCACHE=no \
    && make clean-junk \
    && rm -rf pkg
