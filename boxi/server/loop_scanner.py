import serial
import json
import requests
from get_ip_addr import get_ip_addr
#from datetime import datetime
#from time import sleep
from config_wifi import config_wifi
from lcd import LCD_disp
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
            config_wifi(ssid, pwd)
            LCD_disp("Wifi setup failed!")

if __name__ == "__main__":
    # current IP address of pi
    box_ip = get_ip_addr()
    loop_scanner("http://" + box_ip + ":4321")