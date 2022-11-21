sudo docker run --net=host --privileged --volume=/dev:/dev -it ros_serial:latest /bin/bash && \
source devel/setup.bash && \
sudo su && \
#roscore &&
#rosrun rosserial_arduino serial_node.py _port:=/dev/ttyACM0 _baud:=250000 && \
#rosrun rosserial_arduino serial_node.py _port:=/dev/ttyACM1 _baud:=250000 __name:=_serial_node && \
roslaunch serial_sensors serial.launch