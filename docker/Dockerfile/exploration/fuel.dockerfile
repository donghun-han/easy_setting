FROM melodic_base:v1.0
# ./build_docker.sh exp_fuel:v1.0 ./Dockerfile/exploration/fuel.dockerfile 

ENV DEBIAN_FRONTEND=noninteractive
USER $ROOT

# SSH for git
RUN mkdir /root/.ssh
RUN git config --global user.name "donghun-han" && \
    git config --global user.email "donghun.han@kaist.ac.kr"
ARG ssh_prv_key
ARG ssh_pub_key
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

# Dev Setup
RUN mkdir -p ~/catkin_ws/src && \
    source /opt/ros/melodic/setup.bash && \
    catkin_init_workspace ~/catkin_ws/src && \
    cd ~/catkin_ws && \
    catkin_make -DCMAKE_BUILD_TYPE=Release && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/catkin_ws && \
    source ~/catkin_ws/devel/setup.bash

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    echo "source /home/${USERNAME}/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    echo "alias eb='vim /home/${USERNAME}/.bashrc'" >> ~/.bashrc && \
    echo "alias sb='source /home/${USERNAME}/.bashrc'" >> ~/.bashrc && \
    echo "alias cw='cd /home/${USERNAME}/catkin_ws'" >> ~/.bashrc && \
    echo "alias cs='cd /home/${USERNAME}/catkin_ws/src'" >> ~/.bashrc && \
    echo "alias cm='cd /home/${USERNAME}/catkin_ws && catkin_make'" >> ~/.bashrc

# Dependencies for FUEL
RUN apt-get update && apt-get install -y --no-install-recommends \
        libarmadillo-dev \
        libdw-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*    

WORKDIR /home/$USERNAME
RUN git clone git@github.com:stevengj/nlopt.git && \
    cd nlopt && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j4 && \
    make install

# FUEL
WORKDIR /home/$USERNAME/catkin_ws/src
RUN git clone git@github.com:HKUST-Aerial-Robotics/FUEL.git

# Remove SSH keys
RUN rm /root/.ssh/id_rsa*

RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

USER $USERNAME

# Build
WORKDIR /home/$USERNAME/catkin_ws
