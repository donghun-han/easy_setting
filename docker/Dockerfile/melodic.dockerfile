FROM nvidia/cuda:11.7.1-devel-ubuntu18.04 

# FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu18.04 
# ./build_docker.sh melodic_base:v1.0 ./Dockerfile/melodic.dockerfile 
# ./run_docker.sh melodic_base melodic_base:v1.0

ARG SSH_KEY

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV USERNAME docker_melodic
ENV HOME /home/$USERNAME
ENV ROS_VERSION melodic

ENV DEBIAN_FRONTEND noninteractive

# add new sudo user
RUN useradd -m $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod --shell /bin/bash $USERNAME && \
    usermod -aG sudo $USERNAME && \
    mkdir /etc/sudoers.d && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # Replace 1000 with your user/group id
    usermod  --uid 1000 $USERNAME && \
    groupmod --gid 1000 $USERNAME

# Install basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        vim \
        git \
        curl \
		wget \
        libssl-dev \
        libboost-dev \
		ca-certificates \
		openssh-client \
        nautilus \
        build-essential \
        bash-completion \
        xdg-user-dirs \
        software-properties-common \
        python-pip \
        tmux \
        tmuxp \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Kitware/CMake/releases/download/v3.16.0/cmake-3.16.0.tar.gz && \
    tar zxf cmake-3.16.0.tar.gz && \
    cd cmake-3.16.0 && \
    ./bootstrap && \
    make && \
    make install

# install vs code - not tested yet
# RUN sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg' && \
#     sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
#     apt-get update && apt-get install -y --no-install-recommends \
#         code \
#         && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install -y --no-install-recommends \
        ros-${ROS_VERSION}-desktop-full \
        python-rosdep \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rosdep init

USER $USERNAME
WORKDIR /home/$USERNAME
RUN rosdep update

SHELL ["/bin/bash", "-c"]