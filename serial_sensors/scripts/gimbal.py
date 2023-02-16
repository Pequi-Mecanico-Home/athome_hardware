#!/usr/bin/env python
# license removed for brevity
import rospy
import numpy as np
from sensor_msgs.msg import JointState
from std_msgs.msg import Int16MultiArray 

def callback(data):
	rate.sleep()

def talker():
	global pub, rate
	pub = rospy.Publisher('micro/gimbal', Int16MultiArray, queue_size=1)
	rospy.init_node('rosserial_servo', anonymous=True)
	rospy.Subscriber("micro/Servo", JointState, callback, queue_size=1)
	rate = rospy.Rate(1)
	
	estado_inicial = Int16MultiArray()
	estado_nav = Int16MultiArray()
	estado_vision = Int16MultiArray()

	estado_inicial.data = [100, 100]
	estado_nav.data = [400, 400]
	estado_vision.data = [800 , 800]

	while not rospy.is_shutdown():
		estado = rospy.get_param("/servo/estado")

		if estado == 'vision':
			pub.publish(estado_vision)
		elif estado == 'nav':
			pub.publish(estado_nav)
		else:
			pub.publish(estado_inicial)
		
		rate.sleep()

if __name__ == '__main__':
	try:
		print("Running")
		talker()

	except rospy.ROSInterruptException:

		pass