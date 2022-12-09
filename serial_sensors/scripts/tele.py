#!/usr/bin/env python
# license removed for brevity
import math
import rospy

from std_msgs.msg import Int16MultiArray, Int16, Float32
import numpy as np

#float
#qI, qJ, qK, qW, speed_linear, speed_ang, odom_X, odom_Y, odom_THETA
#int
#batVoltage, boardTemp
def callback(data):
	#print('micro/imu', data)
	pubBattery.publish(data.data[0]/ 104.0)
	pubTemp.publish(data.data[1])
	rate.sleep()

pubBattery = rospy.Publisher('battery', Float32, queue_size=1)
pubTemp = rospy.Publisher('Temp', Int16, queue_size=1)
rospy.init_node('rosserial_tele', anonymous=True)
rospy.Subscriber("/micro/Tele",Int16MultiArray, callback, queue_size=1)
rate = rospy.Rate(5)

def talker():

	rospy.spin()

if __name__ == '__main__':
	try:
		print("Running")
		talker()
	except rospy.ROSInterruptException:
		pass