import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)

# setting gpio pin 36 as out pin

lock_trip = 36

GPIO.setmode(GPIO.BOARD)
GPIO.setup(lock_trip, GPIO.OUT)

# trip func: outputs on gpio pin 36 for 1 millisecond
def trip():
    GPIO.output(lock_trip, GPIO.HIGH)
    time.sleep(0.1)
    GPIO.output(lock_trip, GPIO.LOW)

if __name__ == "__main__":
	trip()
