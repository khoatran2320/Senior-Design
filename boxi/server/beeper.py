import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)

# setting gpio pin 36 as out pin

beeper_trip = 37

GPIO.setmode(GPIO.BOARD)
GPIO.setup(beeper_trip, GPIO.OUT)

# trip func: outputs on gpio pin 36 for 1 millisecond
def beep():
	#buzzer = GPIO.PWM(beeper_trip,1000)
	n = 0
	while(n < 1):
		#buzzer = GPIO.PWM(beeper_trip, 1000)
		print("beeping")
		#buzzer.start(10)
		GPIO.output(beeper_trip, GPIO.HIGH)
		time.sleep(0.5)
		print("beeped")
		buzzer.stop()
		time.sleep(0.5)
		n += 1
		GPIO.output(beeper_trip, GPIO.LOW) 
		#time.sleep(1)

if __name__ == "__main__":
	beep()	
	#beep()
