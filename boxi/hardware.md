Hardware readme

# Table of Contents
1. [Power Requirements](#Power Requirements)
2. [Pinout](#Pinout)
3. [Pictures](#Pictures)
4. [Data Sheets](#Data Sheets)
5. [Reference](#References)


## Power Requirements
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

## Pinout

## Pictures
<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_PS_Relays_Alarm.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_Pi_VibrationSensor.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_BarcodeScanner.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Interior_All.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Rear.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Opened.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_LCD.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Isometric.jpg" width="400" height="400">

<img src="https://github.com/khoatran2320/Senior-Design/blob/master/boxi/images/Exterior_Closed.jpg" width="400" height="400">

## Data Sheets
* Barcode reader
* Vibration Sensor

## References
