sudo docker run --volume=/dev:/dev -it athome/hardware:1.0 /bin/bash && \
source devel/setup.bash && \
#roscore &&
#rosrun rosserial_arduino serial_node.py _port:=/dev/ttyACM0 _baud:=250000 && \
#rosrun rosserial_arduino serial_node.py _port:=/dev/ttyACM1 _baud:=250000 __name:=_serial_node && \
roslaunch athome_hardware athome_hardware.launch