file_content = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\nupdate_config=1\ncountry=US\n\nnetwork={\n\tssid=\"Group_5\"\n\tpsk=\"smartsys\"\t\n\tkey_mgmt=WPA-PSK\n\tscan_ssid=1\n}"
print(file_content)
# wifi_config_file = open("~/etc/wpa_supplicant/wpa_supplicant.conf", "w")
# wifi_config_file.write(file_content)
# wifi_config_file.close()
