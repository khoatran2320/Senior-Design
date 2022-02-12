import RPi.GPIO as GPIO
from time import sleep

GPIO.setwarnings(False)

# setting gpio pin 36 as out pin

lock_trip = 23

#lock_status = 17
lock_status = 12
#lock_status_in = 27

GPIO.setmode(GPIO.BCM)
#GPIO.setmode(GPIO.BOARD)
GPIO.setup(lock_trip, GPIO.OUT)
GPIO.setup(lock_status, GPIO.IN)
#GPIO.setup(lock_status_in, GPIO.IN)
# trip func: outputs on gpio pin 36 for 1 millisecond
def trip():
    GPIO.output(lock_trip, GPIO.HIGH)
    time.sleep(.1)
    GPIO.output(lock_trip, GPIO.LOW)

# is_trip func: outputs on gpio pin 33 for 1 millisecond
def is_trip():
	locked = GPIO.input(lock_status)
	if(locked):
		print('locked')
	else:
		print('not locked')
	return locked
if __name__ == "__main__":
	while True:
		is_trip()
		sleep(.1)
