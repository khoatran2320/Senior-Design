import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)

# setting gpio pin 36 as out pin

lock_trip = 36
lock_status = 33

GPIO.setmode(GPIO.BOARD)
GPIO.setup(lock_trip, GPIO.OUT)

GPIO.setup(lock_status, GPIO.IN)

# trip func: outputs on gpio pin 36 for 1 millisecond
def trip():
	GPIO.output(lock_trip, GPIO.HIGH)
	time.sleep(0.1)
	GPIO.output(lock_trip, GPIO.LOW)

# is_trip func: outputs on gpio pin 33 for 1 millisecond
def is_trip():
	locked = not GPIO.input(lock_status)
	if(locked):
		print('locked')
	else:
		print('not locked')

if __name__ == "__main__":
	is_trip()
	trip()
	is_trip()
