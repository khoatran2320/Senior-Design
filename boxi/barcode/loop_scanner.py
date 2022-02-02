import serial
import json
import requests
#from datetime import datetime
#from time import sleep

ser = serial.Serial('/dev/ttyS0', 9600)

#, timeout=5,parity=serial.PARITY_ODD
def readData():
    buffer = ""
    while True:
        oneByte = ser.read(1)
        if oneByte == b"\r":
            return buffer
        else:
            buffer += oneByte.decode("ascii")
def loop_scanner(post_url=None):
	ind = 0
	while True:
		barcode = readData()
		barcode_dict = dict({ind:barcode})
		ind += 1
		print(barcode_dict)
		if post_url != None:
			try:
				r = requests.post(post_url, json=barcode_dict, verify=False)
			except:
				pass
"""while True:
    barcode = readData()
    ind += 1
    barcode_dict = dict({ind:barcode})
    #print(barcode_dict)
    #with open("barcodes.json", "a") as outfile:
    #    json.dump(barcode_dict, outfile)
    print(barcode_dict)
    r = requests.post('http://10.192.32.116:4321/barcode', json=barcode_dict, verify=False)
    #print(f"Status Code: {r.status_code}, Response: {r.json()}")
    #r = requests.get('http
    #recieved_data = ser.read()
    
    #sleep(0.03)
    #data_left = ser.inWaiting()
    #recieved_data = ser.read(data_left)
    #print('Reading data')
    #print(recieved_data)
    #ser.write(recieved_data)
"""
if __name__ == "__main__":
	loop_scanner("http://10.192.32.116:4321/barcode")
