from ipaddress import ip_address
from flask import Flask, request, jsonify
import requests
#from utilities.file_utils import read_txt_file, write_txt_file
from utilities.get_box_user_id import get_box_user_id
from utilities.get_node_server_ip import get_node_server_ip
from trip_lock import trip
from beeper import beep
from get_ip_addr import get_ip_addr
from lcd import LCD_disp

app = Flask(__name__)
PORT = 4321
NODE_PORT = 3000
NODE_IP = get_node_server_ip()

def set_ip_addr():
	ip_address = get_ip_addr()
	reqBody = get_box_user_id()
	reqBody['ipAddr'] = ip_address
	reqBody['port'] = PORT

	print(reqBody)
	try:
		url = f"http://{NODE_IP}:{NODE_PORT}/boxi/post-ip"		
		r = requests.post(url, json=reqBody, verify=False)
		print(r.text, r.status_code)
	except:
		print("Set IP failed")

def validate_request(body):
	if not body:
		print("request body not found!")
		return False
	reUserId = body["userId"]
	if not reUserId:
		print("user ID not found in request")
		return False

	storedUserId = get_box_user_id()['userId']
	if storedUserId != reUserId:
		print("User IDs do not match!")
		print("userId: ", reUserId)
		print("stored usr Id: ", storedUserId)
		return False
	return True


@app.route('/')
def index():
	return 'Hello World\n'

@app.route('/barcode', methods=["POST"])
def barcode():
	body = request.json
	if body:
		print(body)
		reqBody = get_box_user_id()
		barcode = None
		for item in body:
			barcode = body[item]
		reqBody['trackingNumber'] = barcode

		# TODO: Manually update this every time
		# Node server's IP address
		# ifconfig command, look at en0 for IP address
		url = f"http://{NODE_IP}:{NODE_PORT}/boxi/package"
		r = requests.get(url, params=reqBody)

		print(r.text, r.status_code)
		if r.status_code == 200:
			trip()
			LCD_disp("BOXi unlocked!")
			#open lock
		else:
			LCD_disp("Barcode Failed!")
	else:
		print("Did not receive body")
	return jsonify("hello")

@app.route('/unlock', methods=["POST"])
def unlock():
	body = request.json
	if validate_request(body):
		try:
			trip()
			LCD_disp("BOXi unlocked!")
		except Exception as e:
			LCD_disp("Failed")
			errorMessage = "Failed to unlock BOXi\n" + e
			return jsonify(status=500, msg=errorMessage)
		else:
			return jsonify(status=200, msg="Success")
	else:
		return jsonify(status=400, msg="Bad request")

@app.route('/alarm', methods=["POST"])
def alarm():
	body = request.json
	if validate_request(body):
		LCD_disp("ALARM!")
		beep(20)
		return "Success"
	else:
		return "Unsuccessful"


@app.route('/lock-status', methods=["POST"])
def lock_status():
	body = request.json
	if body:
		print(body)
		reqBody = get_box_user_id()
		l_stat = None
		for item in body:
			l_stat = body[item]
		reqBody['isUnlocking'] = l_stat

		# TODO: Manually update this every time
		# Node server's IP address
		# ifconfig command, look at en0 for IP address
		url = f"http://{NODE_IP}:{NODE_PORT}/boxi/unlock"
		r = requests.get(url, params=reqBody)

		print(r.text, r.status_code)
		if r.status_code == 200:
			print("posted lock status")
			#open lock
		else:
			print("failed to post lock status")
	else:
		print("Did not receive body")
	return jsonify("hello")


@app.route('/alarm-status', methods=["POST"])
def alarm_status():
	body = request.json
	if body:
		print(body)
		reqBody = get_box_user_id()
		l_stat = None
		for item in body:
			l_stat = body[item]
		reqBody['isAlarming'] = l_stat

		# TODO: Manually update this every time
		# Node server's IP address
		# ifconfig command, look at en0 for IP address
		url = f"http://{NODE_IP}:{NODE_PORT}/boxi/alarm"
		r = requests.post(url, json=reqBody)

		print(r.text, r.status_code)
		if r.status_code == 200:
			print("posted alarmm status")
			#open lock
		else:
			print("failed to post alarm status")
	else:
		print("Did not receive body")
	return jsonify("hello")


@app.route('/weight')
def weight():
    return True

@app.route('/vibration')
def vibration():
    return True

if __name__ == '__main__':
	set_ip_addr()
	app.run(host='0.0.0.0', port=PORT)
