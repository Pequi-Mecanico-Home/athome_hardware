#!/usr/bin/env python
# license removed for brevity
import math
import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import Float32MultiArray
import numpy as np

def callback(data):

    #print('cmd_vel', data)
    position = data
    #print('micro/cmd_vel', position)
    pubPosition.publish(position)
    rate.sleep()

pubPosition = rospy.Publisher('micro/cmd_vel', Twist, queue_size=1)
rospy.init_node('rosserial_cmd_vel', anonymous=True)
rospy.Subscriber("cmd_vel", Twist, callback, queue_size=1)
rate = rospy.Rate(5)

def talker():

	rospy.spin()

if __name__ == '__main__':
	try:
		print("Running")
		talker()
	except rospy.ROSInterruptException:
		pass
