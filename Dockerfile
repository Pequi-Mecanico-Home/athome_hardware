FROM ros:noetic

ENV ROS_DISTRO noetic
ENV  PATH="$PATH:/usr/bin/python3"

RUN apt -q -qq update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    software-properties-common \
    wget \
    apt-transport-https

RUN apt -q -qq update && \
  DEBIAN_FRONTEND=noninteractive apt install -y --allow-unauthenticated \
  #python-rosinstall \
  #python-catkin-tools \
  ca-certificates \
    git \
    build-essential \
    cmake \
    ninja-build \
    python3-catkin-tools \
    software-properties-common \
    ros-$ROS_DISTRO-realsense2-camera \
    ros-$ROS_DISTRO-image-transport* \
    ros-$ROS_DISTRO-rgbd-launch \
    python3-rosinstall \
    python3-catkin-tools \
    python3-pip \
    ros-$ROS_DISTRO-joy \
    ros-$ROS_DISTRO-teleop-twist-joy \
    ros-${ROS_DISTRO}-jsk-tools \
    ros-${ROS_DISTRO}-rgbd-launch \
    ros-${ROS_DISTRO}-image-transport-plugins \
    ros-${ROS_DISTRO}-image-transport \
    software-properties-common \
    ros-${ROS_DISTRO}-rosserial-python \
    wget 

RUN sudo sh \
    -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
        > /etc/apt/sources.list.d/ros-latest.list'

RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
RUN apt-get update
RUN pip3 install -U catkin_tools


RUN rosdep update


RUN mkdir -p /hardware_ws/src
COPY . ./hardware_ws/src/
WORKDIR /hardware_ws
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; catkin build' && \ 
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \ 
    echo "source /hardware_ws/devel/setup.bash" >> /root/.bashrc 

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]