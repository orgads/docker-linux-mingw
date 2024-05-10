FROM debian:testing-slim
RUN printf 'APT::Get::Install-Recommends "false";\nAPT::Get::Install-Suggests "false";' > /etc/apt/apt.conf.d/10no-recommends
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
    gawk \
    gettext \
    git \
    gperf \
    groff-base \
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
    python3-mako \
    python3-pip \
    rsync \
    ruby \
    sed \
    sudo \
    texinfo \
    unzip \
    vim \
    wget \
    xz-utils \
    && rm -rf \
      /usr/share/doc \
      /usr/share/info \
      /usr/share/locale \
      /usr/share/man

ENV PATH=$PATH:/opt/mxe/usr/bin

RUN git clone https://github.com/mxe/mxe /opt/mxe
RUN cd /opt/mxe && \
    make -j$(nproc) JOBS=$(nproc) \
    bfd \
    boost \
    cmake \
    gcc \
    libgnurx \
    libiberty \
    libxml2 \
    libxslt \
    lld \
    mingw-w64 \
    zlib \
    MXE_TARGETS=i686-w64-mingw32.static \
    MXE_PLUGIN_DIRS=plugins/gcc14 \
    MXE_USE_CCACHE=no \
    && make clean-junk \
    && rm -rf \
      pkg \
      /opt/mxe/usr/i686-w64-mingw32.static/share/*doc \
      /opt/mxe/usr/x86_64-pc-linux-gnu/doc \
      /opt/mxe/usr/x86_64-pc-linux-gnu/share/cmake-3.29/Help \
      /opt/mxe/usr/x86_64-pc-linux-gnu/share/locale
