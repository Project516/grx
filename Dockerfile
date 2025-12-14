FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# 1. Enable ARM architecture
RUN dpkg --add-architecture armel

# 2. Update and install Cross-Build Tools
RUN apt-get update && apt-get install -y \
    crossbuild-essential-armel \
    git \
    build-essential \
    devscripts \
    debhelper \
    dh-exec \
    pkg-config \
    sudo \
    # Install GRX native tools (x86)
    cmake \
    libglib2.0-dev \
    gir1.2-glib-2.0 \
    gobject-introspection \
    gtk-doc-tools \
    libgirepository1.0-dev \
    libglib2.0-doc \
    pandoc \
    python3 \
    valac \
    valadoc \
    # Install GRX ARM libraries (armel)
    libglib2.0-dev:armel \
    libgtk-3-dev:armel \
    libgudev-1.0-dev:armel \
    libinput-dev:armel \
    libjpeg-dev:armel \
    libpng-dev:armel \
    libudev-dev:armel \
    libxkbcommon-dev:armel \
    && rm -rf /var/lib/apt/lists/*

# 3. Create a user to build as
RUN useradd -m compiler && echo "compiler ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER compiler
WORKDIR /src