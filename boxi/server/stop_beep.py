import RPi.GPIO as GPIO
beeper_trip = 26
GPIO.setmode(GPIO.BCM)
GPIO.setup(beeper_trip, GPIO.OUT)
from time import sleep
while True:
	GPIO.output(beeper_trip,GPIO.LOW)
	sleep(0.2)
