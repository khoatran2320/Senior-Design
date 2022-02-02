import serial

def readData():
    ser = serial.Serial('/dev/ttyS0', 9600)
    buffer = ""
    
    while True:
        oneByte = ser.read(1)
        if oneByte == b"\r":
            return buffer
        else:
            buffer += oneByte.decode("ascii")
            
    ser.close()
    
    return buffer