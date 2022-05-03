from json import load
import RPi.GPIO as GPIO
import time
import requests
from get_ip_addr import get_ip_addr
from lcd import LCD_disp

GPIO.setwarnings(False)

# setting gpio pin 36 as out pin

beeper_trip = 26

GPIO.setmode(GPIO.BCM)
GPIO.setup(beeper_trip, GPIO.OUT)

# trip func: outputs on gpio pin 36 for 1 millisecond

def beep(iterations=1, post_url=None):
	with open("/home/pi/Desktop/Senior-Design/boxi/server/utilities/alarm_config.txt") as f:
		lines = [line.rstrip('\n') for line in f]
		if lines == "off":
			return
	buzzer = GPIO.PWM(beeper_trip,1000)
	n = 0

	if post_url != None:
		load = dict({"a_status" : True})
		print(load)
		try:
			r = requests.post(post_url, json=load, verify=False)
		except:
			pass
	LCD_disp("ALARMING")
	while(n < iterations):
		#buzzer = GPIO.PWM(beeper_trip, 1000)
		print("beeping")

		# 10% duty cycle
		# buzzer.start(10)
		GPIO.output(beeper_trip, GPIO.HIGH)
		time.sleep(0.25)
		print("beeped")
		#buzzer.stop()
		time.sleep(0.25)
		n += 1
		GPIO.output(beeper_trip, GPIO.LOW) 
		#time.sleep(1)
	LCD_disp("")
	if post_url != None:
		load = dict({"a_status" : False})
		try:
			r = requests.post(post_url, json=load, verify=False)
		except:
			pass
	buzzer.stop()
if __name__ == "__main__":
	box_ip = get_ip_addr()
	beep(3, "http://" + box_ip + ":4321/alarm-status")	
	#beep()
