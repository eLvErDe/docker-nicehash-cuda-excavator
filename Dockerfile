FROM debian:stretch

MAINTAINER Adam Cecile <acecile@le-vert.net>

ENV TERM xterm
ENV HOSTNAME dstm-cuda-zm.local
ENV DEBIAN_FRONTEND=noninteractive
ENV GITHUB_URL=https://github.com/nicehash/excavator/releases/download/v1.3.8a/excavator_1.3.8a-xenial0_amd64.deb

WORKDIR /root

# Upgrade base system
RUN apt update \
    && apt --yes dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update && apt --yes --no-install-recommends install wget ca-certificates dpkg-dev && rm -rf /var/lib/apt/lists/*

# Install binary
RUN mkdir /tmp/repo \
    && wget "${GITHUB_URL}" -P /tmp/repo/ \
    && cd /tmp/repo/ && dpkg-scanpackages . /dev/null > /tmp/repo/Packages && cd \
    && echo "deb [trusted=yes] file:/tmp/repo /" > /etc/apt/sources.list.d/local.list \
    && apt update \
    && apt --yes install excavator \
    && rm -f /etc/apt/sources.list.d/local.rep \
    && rm -rf /tmp/repo \
    && rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime @ https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/8.0/runtime/Dockerfile
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
