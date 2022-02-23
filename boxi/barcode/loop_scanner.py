import serial
import json
import requests

ser = serial.Serial('/dev/ttyS0', 9600)

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
        print(barcode_dict)
        if post_url != None:
            try:
                r = requests.post(post_url, json=barcode_dict, verify=False)
            except:
                pass

if __name__ == "__main__":
    loop_scanner("http://10.192.32.116:4321/barcode")