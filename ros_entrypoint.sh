#!/bin/bash
set -e



source "/opt/ros/$ROS_DISTRO/setup.bash"

source /~/ros_workspace/devel/setup.bash
exec "$@"