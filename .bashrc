#==============================================================================
# Copy and paste the following lines to the end of the file
#==============================================================================

#----------------------------------------------------------
# Path & Environment Variables
#----------------------------------------------------------
export PATH=/usr/local/cuda-11.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH

export WS_DIR="${HOME}/Master/SubtExp/catkin_ws"

source /opt/ros/noetic/setup.bash
source ${WS_DIR}/devel/setup.bash

# PX4 SITL
source ${HOME}/PX4-Autopilot/Tools/simulation/gazebo-classic/setup_gazebo.bash ${HOME}/PX4-Autopilot ${HOME}/PX4-Autopilot/build/px4_sitl_default
export ROS_PACKAGE_PATH=${HOME}/PX4-Autopilot:${HOME}/PX4-Autopilot/Tools/simulation/gazebo-classic/sitl_gazebo-classic:${ROS_PACKAGE_PATH}
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:${HOME}/PX4-Autopilot/Tools/simulation/gazebo-classic/sitl_gazebo-classic/models
export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:${HOME}/PX4-Autopilot/build/px4_sitl_default/build_gazebo-classic

export PX4_HOME_LAT="36.373810"
export PX4_HOME_LON="127.365637"

#----------------------------------------------------------
# Alias
#----------------------------------------------------------

# General
alias al="alias"

alias mkdir="mkdir -p"

alias c="clear"
alias h="history"
alias hgrep="history | grep"

alias aptu="sudo apt-get update"
alias apti="sudo apt-get install -y"

alias sb="source ${HOME}/.bashrc"
alias eb="vim ${HOME}/.bashrc"

alias qq="sudo shutdown now"

# Git alias
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias gps="git push"

# Docker alias
alias dps="docker ps -a"
alias dex="docker exec -it" # Usage: dex <container_name> /bin/bash
alias dk="docker ps -q | awk '{print $1}' | xargs -o docker stop" # Stop all containers
alias dclean="docker system prune -a" # Remove all unused containers, networks, images etc.

# For ROS
alias tk="tmux kill-session"
alias gzk="killall -9 gzclient; killall -9 gzserver;"

alias cw="cd ${WS_DIR}"
alias cs="cd ${WS_DIR}/src"
alias cm="cd ${WS_DIR} && catkin_make"

# PX4
alias qgc="${HOME}/QGroundControl.AppImage"

clear