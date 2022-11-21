#!/usr/bin/env python
# license removed for brevity
import math
import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import String
import numpy as np
from nav_msgs.msg import Odometry
#float
#qI, qJ, qK, qW, speed_linear, speed_ang, odom_X, odom_Y, odom_THETA
#int
#batVoltage, boardTemp
def callback(data):
	#print('micro/odom', data)
	pubPosition.publish(data)
	rate.sleep()

pubPosition = rospy.Publisher('Odom', Odometry, queue_size=1)
rospy.init_node('rosserial_odom', anonymous=True)
rospy.Subscriber("/micro/Odom", Odometry, callback, queue_size=1)
rate = rospy.Rate(5)

def talker():

	rospy.spin()

if __name__ == '__main__':
	try:
		print("Running")
		talker()
	except rospy.ROSInterruptException:
		pass
