#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/hardware_ws/devel/setup.bash" 
exec "$@"