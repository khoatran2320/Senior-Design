import RPi.GPIO as GPIO
from time import sleep
from beeper import beep
from get_ip_addr import get_ip_addr
# vibration sensor on pin 16 (gpio 22)
vib_pin = 22

GPIO.setmode(GPIO.BCM)
GPIO.setup(vib_pin, GPIO.IN)

def vib():
	reading = GPIO.input(vib_pin)
	if reading:
		print("Alarm")
	else:
		print("normal")
	return reading

def loop_vib(it=20, post_url=None):
	counter = 0
	while(1):
		if counter > 99999999:
			counter = 0
		if counter > it:
			beep(3, post_url)
		if vib():
			counter += 1
		else:
			counter = 0
		sleep(0.1)
if __name__ == "__main__":
	box_ip = get_ip_addr()
	url = f"http://{box_ip}:4321/alarm-status"
	loop_vib(10, url)
