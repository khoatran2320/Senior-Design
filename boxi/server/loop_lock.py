from webbrowser import get
from trip_lock import is_trip
from time import sleep
import requests
from get_ip_addr import get_ip_addr

def loop_lock(post_url=None):
    lock_status = False
    while(1):
        new_lock_status = is_trip()
        if new_lock_status != lock_status:
            print("lock toggled")
            lock_status = new_lock_status

            load = dict({'l_status': lock_status})
            if post_url != None:
                try:
                    r = requests.post(post_url, json=load, verify=False)
                except:
                    pass
        sleep(.5)

if __name__ == "__main__":
    box_ip = get_ip_addr()
    loop_lock("http://" + box_ip + ":4321/lock-status")
