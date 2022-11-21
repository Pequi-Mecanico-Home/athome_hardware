FROM ros:melodic

ENV ROS_DISTRO melodic
ENV  PATH="$PATH:/usr/bin/python3"

# install ROS Realsense pacakge
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        build-essential \
        cmake \
        ninja-build \
        software-properties-common \
        ros-$ROS_DISTRO-realsense2-camera \
        ros-$ROS_DISTRO-image-transport* \
        ros-$ROS_DISTRO-rgbd-launch && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN apt -q -qq update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    software-properties-common \
    wget \
    apt-transport-https




RUN apt -q -qq update && \
    DEBIAN_FRONTEND=noninteractive apt install -y --allow-unauthenticated \
    python-rosinstall \
    python-catkin-tools \
    python3-pip \
    ros-$ROS_DISTRO-joy \
    ros-$ROS_DISTRO-teleop-twist-joy \
    ros-${ROS_DISTRO}-jsk-tools \
    ros-${ROS_DISTRO}-rgbd-launch \
    ros-${ROS_DISTRO}-image-transport-plugins \
    ros-${ROS_DISTRO}-image-transport


ENV ATHOME_WS=/root/athome_ws
COPY . $ATHOME_WS/src

#build athome stack
WORKDIR $ATHOME_WS
RUN catkin config \
        --extend /opt/ros/${ROS_DISTRO} \
        --cmake-args -DCMAKE_BUILD_TYPE=Release \
        && catkin build --no-status athome_hardware -j$(($(nproc)-1))

RUN echo "source $ATHOME_WS/devel/setup.bash" > /root/.bashrc
COPY ros_entrypoint.sh /

WORKDIR $ATHOME_WS
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
