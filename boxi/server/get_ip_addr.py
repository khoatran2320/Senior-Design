#from requests import get
import socket

def get_ip_addr():
    #ip_addr = get('https://api.ipify.org').content.decode('utf8')
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(('8.8.8.8', 80))
    ip_addr = s.getsockname()[0]
    s.close()
    return ip_addr

if __name__ == "__main__":
    print(get_ip_addr())
