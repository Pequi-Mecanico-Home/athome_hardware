#!/usr/bin/env python
# license removed for brevity
import math
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Imu
from std_msgs.msg import String
import numpy as np
from nav_msgs.msg import Odometry
#float
#qI, qJ, qK, qW, speed_linear, speed_ang, odom_X, odom_Y, odom_THETA
#int
#batVoltage, boardTemp
def callback(data):
	#print('micro/imu', data)
#	data.orientation_covariance = 0.01
#	data.angular_velocity_covariance = 0.01
#	data.linear_acceleration_covariance = 0.01
	pubPosition.publish(data)
	rate.sleep()

pubPosition = rospy.Publisher('IMU', Imu, queue_size=1)
rospy.init_node('rosserial_imu', anonymous=True)
rospy.Subscriber("/micro/IMU", Imu, callback, queue_size=1)
rate = rospy.Rate(5)

def talker():

	rospy.spin()

if __name__ == '__main__':
	try:
		print("Running")
		talker()
	except rospy.ROSInterruptException:
		pass