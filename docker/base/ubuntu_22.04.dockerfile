FROM ubuntu:22.04

ARG UID
ARG GID

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        lsb-release \
        ca-certificates \
        software-properties-common \
        gnupg2 \
        bash-completion \
        sudo \
        build-essential \
        cmake \
        curl \
        vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user, and grant password-less sudo permissions
RUN addgroup --gid $GID usrg && \
    adduser --uid $UID --gid $GID --disabled-password --gecos '' usrg && \
    echo 'usrg ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER usrg
WORKDIR /home/usrg