# Multi-stage Dockerfile for ESP32 and Raspberry Pi Pico development

FROM ubuntu:22.04 as base

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install common dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    flex \
    bison \
    gperf \
    python3 \
    python3-pip \
    python3-venv \
    cmake \
    ninja-build \
    ccache \
    libffi-dev \
    libssl-dev \
    dfu-util \
    libusb-1.0-0 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ============================================
# ESP32 Development Stage
# ============================================
FROM base as esp32-dev

# Install ESP-IDF prerequisites
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    && rm -rf /var/lib/apt/lists/*

# Set up ESP-IDF
ENV IDF_PATH=/opt/esp-idf
ENV IDF_TOOLS_PATH=/opt/espressif

RUN git clone --recursive https://github.com/espressif/esp-idf.git ${IDF_PATH} && \
    cd ${IDF_PATH} && \
    git checkout v5.1.2 && \
    ./install.sh esp32

# Set up environment
RUN echo "source ${IDF_PATH}/export.sh" >> /root/.bashrc

WORKDIR /workspace

CMD ["/bin/bash"]

# ============================================
# Raspberry Pi Pico Development Stage
# ============================================
FROM base as pico-dev

# Install Pico SDK prerequisites
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib \
    && rm -rf /var/lib/apt/lists/*

# Set up Pico SDK
ENV PICO_SDK_PATH=/opt/pico-sdk

RUN git clone https://github.com/raspberrypi/pico-sdk.git ${PICO_SDK_PATH} && \
    cd ${PICO_SDK_PATH} && \
    git submodule update --init

# Set up environment
RUN echo "export PICO_SDK_PATH=${PICO_SDK_PATH}" >> /root/.bashrc

WORKDIR /workspace

CMD ["/bin/bash"]

# ============================================
# Combined Development Environment (default)
# ============================================
FROM base as combined

# Install all prerequisites
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib \
    && rm -rf /var/lib/apt/lists/*

# Set up ESP-IDF
ENV IDF_PATH=/opt/esp-idf
ENV IDF_TOOLS_PATH=/opt/espressif

RUN git clone --recursive https://github.com/espressif/esp-idf.git ${IDF_PATH} && \
    cd ${IDF_PATH} && \
    git checkout v5.1.2 && \
    ./install.sh esp32

# Set up Pico SDK
ENV PICO_SDK_PATH=/opt/pico-sdk

RUN git clone https://github.com/raspberrypi/pico-sdk.git ${PICO_SDK_PATH} && \
    cd ${PICO_SDK_PATH} && \
    git submodule update --init

# Set up environment
RUN echo "source ${IDF_PATH}/export.sh" >> /root/.bashrc && \
    echo "export PICO_SDK_PATH=${PICO_SDK_PATH}" >> /root/.bashrc

WORKDIR /workspace

CMD ["/bin/bash"]
