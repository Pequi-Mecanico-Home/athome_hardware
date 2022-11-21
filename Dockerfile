FROM ros:melodic

ENV ROS_DISTRO melodic
ENV  PATH="$PATH:/usr/bin/python3"

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
  ros-${ROS_DISTRO}-jsk-tools \
  ros-${ROS_DISTRO}-rgbd-launch \
  ros-${ROS_DISTRO}-image-transport-plugins \
  ros-${ROS_DISTRO}-image-transport



RUN mkdir ros_workspace && \
    cd ros_workspace && \
    mkdir src && \
    cd src

WORKDIR /~/ros_workspace/src
COPY ./serial_sensors ./serial_sensors

#RUN git clone https://github.com/ros-drivers/rosserial.git -b melodic-devel 

RUN sudo sh \
    -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
        > /etc/apt/sources.list.d/ros-latest.list'

RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
RUN apt-get update
RUN pip3 install -U catkin_tools
RUN apt install -y ros-melodic-rosserial-python
#RUN git clone https://github.com/catkin/catkin_tools.git


#WORKDIR /~/ros_workspace/src/catkin_tools
#RUN pip3 install -r requirements.txt --upgrade
#RUN  python3 setup.py install --record install_manifest.txt
WORKDIR /~/ros_workspace

RUN rosdep update
RUN echo 'source /opt/ros/melodic/setup.bash' >> /root/.bashrc
#RUN sudo su 


RUN sudo chmod +x src/**/**/**

COPY ./ros_entrypoint.sh /
RUN sudo chmod +x /ros_entrypoint.sh


#RUN pip3 install ros-melodic-bfl
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make'
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["roslaunch", "serial_sensors", "serial.launch"]