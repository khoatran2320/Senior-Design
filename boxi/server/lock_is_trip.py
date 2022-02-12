import RPi.GPIO as GPIO
from time import sleep
import requests
from get_ip_addr import get_ip_addr

GPIO.setwarnings(False)

lock_status = 12
GPIO.setmode(GPIO.BCM)
GPIO.setup(lock_status, GPIO.IN)

def send_req(true_lock):
	load = dict({'l_status': true_lock})
	print(load)
	try:
		r = requests.post(post_url, json=load, verify=False)
	except:
		pass
def is_trip(post_url=None):
	true_lock = 0
	if post_url != None:
		load = dict({'l_status': true_lock})
		print(load)
		try:
			r = requests.post(post_url, json=load, verify=False)
		except:
			pass
	count = 0
	toggle = False
	sent_lock = False
	while True:
		sleep(.1)
		if count > 999999:
			# to prevent overflow
			count = count % 100
		count = count + 1
		locked = GPIO.input(lock_status)
		if count > 30 and not sent_lock:
			load = dict({'l_status': true_lock})
			print(load)
			try:
				r = requests.post(post_url, json=load, verify=False)
			except:
				pass
			sent_lock = True
		if true_lock != locked:
			true_lock = locked
			toggle = True
			if post_url != None and count > 30:
				count = 0
				load = dict({'l_status': true_lock})
				print(load)
				try:
					r = requests.post(post_url, json=load, verify=False)
				except:
					pass	
				sent_lock = False
			elif not toggle:
				true_lock = False
			else:
				pass
			count = 0
		print('locked' if true_lock else 'unlocked', '\tcount:', count)
if __name__ == "__main__":
	box_ip = get_ip_addr()
	is_trip('http://' + box_ip + ':4321/lock-status')
