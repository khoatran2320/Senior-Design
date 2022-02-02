import RPi.GPIO as GPIO
import time

# vibration sensor on pin 16 (gpio 22)
vib_pin = 22

GPIO.setmode(GPIO.BCM)
GPIO.setup(vib_pin, GPIO.IN)

def vib():
	reading = GPIO.input(vib_pin)
	if reading:
		print('ALARM')
	else:
		print('normal')
	time.sleep(0.1)

if __name__ == "__main__":
	vib()
	vib()
	vib()
	vib()
	vib()
	vib()
