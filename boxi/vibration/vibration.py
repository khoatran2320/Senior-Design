import RPi.GPIO as GPIO
from time import sleep

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

def loop_vib():
	counter = 0
	while(1):
		if counter > 3:
			return True
		if vib():
			counter += 1
		sleep(0.1)
if __name__ == "__main__":
	loop_vib()
