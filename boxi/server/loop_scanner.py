import serial
import json
import requests
from get_ip_addr import get_ip_addr
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

def parse_barcode(barcode):
    arr = barcode.split('$')
    if arr[0] == '###' and arr[-1] == '###':
        ssid = ''
        pwd = ''
        try:
            ssid = arr[1]
            pwd = arr[2]
        except:
            pass
        return ssid, pwd
    else:
        return 'tracking', '#' 

def loop_scanner(post_url=None):
    ind = 0
    while True:
        ind += 1
        barcode = readData()
        ssid, pwd = parse_barcode(barcode)
        if ssid == 'tracking' and pwd == '#':
            barcode_dict = dict({ind:barcode})
            print(barcode_dict)
            if post_url != None:
                try:
                    r = requests.post(post_url + '/barcode', json=barcode_dict, verify=False)
                except:
                    pass
        else:
            barcode_dict = dict({'ssid':ssid, 'pwd': pwd})
            print(barcode_dict)
            if post_url != None:
                try:
                    r = requests.post(post_url + '/wifi', json=barcode_dict, verify=False)
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
    # current IP address of pi
    r = requests.post('http://10.192.4.148:4321/barcode', json=barcode_dict, verify=False)
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
    # current IP address of pi
    box_ip = get_ip_addr()
    loop_scanner("http://" + box_ip + ":4321")