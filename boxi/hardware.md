Hardware readme

# Table of Contents
1. [Example](#example)
2. [Example2](#example2)
3. [Third Example](#third-example)
4. [Fourth Example](#fourth-examplehttpwwwfourthexamplecom)

# Power Requirements
* 120VAC received via IEC C14 power cable and panel connector
* Internal power supply: 120VAC to 12VDC; grounded with short circuit protection
  * Brand used in prototype is ALITOVE (see BOM); design is not brand-specific; any 120VAC to 12VDC power supply with at least 5A rating and short circuit protection is acceptable
* Electronic lock: Solenoid released with 12VDC, 2A for 100ms
  * RATING IS NOT FLEXIBLE
  * Do not supply power to lock for much longer than 100ms or there is risk of damage to solenoid
* Raspberry Pi: 5VDC via USB
  * Approximately 150 mA when powered on
  * Prototype uses 12VDC to 5VDC USB buck converter connected between power supply and Raspberry Pi
* All sensors: 5VDC via 5VDC pins on Raspberry Pi
  * Marginal current usage

# Pinout

# Pictures
![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_PS_Relays_Alarm.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_Pi_VibrationSensor.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_BarcodeScanner.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_All.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Rear.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Opened.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_LCD.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Isometric.jpg)

![...](https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Closed.jpg)

# Data Sheets
* Barcode reader
* Vibration Sensor
