from flask import Flask, request, jsonify
import requests
#from utilities.file_utils import read_txt_file, write_txt_file
from utilities.get_box_user_id import get_box_user_id
from trip_lock import trip
app = Flask(__name__)

def validate_request(json_body):
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
		r = requests.get("http://168.122.4.172:3000/boxi/package", params=reqBody)

		print(r.text, r.status_code)
		if r.status_code == 200:
			trip()
			#open lock
	else:
		print("Did not receive body")
	return jsonify("hello")

@app.route('/unlock', methods=["POST"])
def unlock():
	body = request.json
	if validate_request(body):
		trip()
		return "Success"
	else:
		return "Unsuccessful"
		
@app.route('/lock')
def lock():
    return True

@app.route('/weight')
def weight():
    return True

@app.route('/vibration')
def vibration():
    return True

if __name__ == '__main__':
	app.run(host='0.0.0.0', port='4321')
