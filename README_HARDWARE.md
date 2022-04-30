Hardware readme

# Table of Contents
1. [Power Requirements](#Power-Requirements)
2. [Pinout](#Pinout)
3. [Pictures](#Pictures)
4. [Data Sheets](#Data-Sheets)
5. [References](#References)


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
| Pin #      | Description |
| -------------  | ----------- | 
| 1         | 3.3V - bus for alarm relay, lock relay, and vibration sensor 
| 2         | 5V - bus for LCD display and barcode reader
| 3         | SDA: barcode reader sda
| 5         | SCL barcode reader scl
| 8         | TXD - barcode reader RXD
| 10         | RXD - barcode reader TXD
| 15         | GPIO 22 - vibration sensor
| 17         | 3.3V - lock status
| 25         | GND - bus for alarm relay, lock relay, barcode reader, lcd display
| 32         | GPIO 12 - lock status
| 36         | GPIO 16 - lock relay
| 37         | GPIO 26 - alarm relay


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
