Hardware readme

# Table of Contents
1. [Example](#Power Requirements)
2. [Example2](#Pinout)
3. [Third Example](#Pictures)
4. [cad](#CAD)
5. [BOM](#Bill of Materials)
6. [Fourth](#References)


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
| Pin | Out |
| ----------- | ----------- |
| 1: 3.3V - bus for alarm relay, lock relay, and vibration sensor | 2: 5V - bus for LCD display and barcode reader |
| 3: SDA: barcode reader sda | 4 |
| 5: SCL barcode reader scl | 6 |
| 7 | 8: TXD - barcode reader RXD |
| 9 | 10: RXD - barcode reader TXD |
| 11 | 12 |
| 13 | 14 |
| 15: GPIO 22 - vibration sensor | 16 |
| 17: 3.3V - lock status | 18 |
| 19 | 20 |
| 21 | 22 |
| 23 | 24 |
| 25: GND - bus for alarm relay, lock relay, barcode reader, lcd display | 26 |
| 27 | 28 |
| 29 | 30 |
| 31 | 32: GPIO 12 - lock status |
| 33 | 34 |
| 35 | 36: GPIO 16 - lock relay |
| 37: GPIO 26 - alarm relay | 38 |
| 39 | 40 |

## Pictures
<img src="https://user-images.githubusercontent.com/55323049/165992801-0ddc3590-58cc-4638-adbb-0a6542c97eca.jpg" alt="Interior_PS_Relays_Alarm" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992804-10c6e22f-94fc-4a91-a960-b56082b78c76.jpg" alt="Exterior_Closed" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992812-e43013be-3202-46d2-b992-501a15ce5a3d.jpg" alt="Exterior_Isometric" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992814-2b693a63-b09b-4d4b-95ff-965a7c1e0428.jpg" alt="Exterior_LCD" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992820-81346d5d-b828-4ed6-9097-79be62867bd2.jpg" alt="Exterior_Opened" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992824-a6d93808-3a16-45f5-8e4c-72549e4daa31.jpg" alt="Exterior_Rear" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992828-42d0e8e3-4ca1-4420-b268-00ada77b429d.jpg" alt="Interior_All" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992830-25d2035c-bdc9-49e4-9e34-ebc2034aa2f2.jpg" alt="Interior_BarcodeScanner" width="300" height="400" />

<img src="https://user-images.githubusercontent.com/55323049/165992833-39ee6f0b-2928-4a47-8494-9bc0ed91d1fe.jpg" alt="Interior_Pi_VibrationSensor" width="300" height="400" />

## CAD models
* Entire CAD
* [Link to google drive containing all the CAD models](https://drive.google.com/drive/u/1/folders/1pPOR1W4jZ5Tcb7VXgC_TN9RHNkHzAnE4)

## Bill of Materials
| Name                             | Price   |
|----------------------------------|---------|
| Raspberry Pi Zero Case           |   $8.99 |
| Wall rivets                      |  $14.24 |
| Hinge Lid Bar                    |   $3.85 |
| Wall channel                     |   $6.14 |
| Lid channel                      |   $4.78 |
| Lid sheet                        | $100.41 |
| Hinge                            |   $2.24 |
| Raspberry Pi Zero 2 W            |  $15.00 |
| IEC C14 Snap-In Male Socket      |   $1.28 |
| Weather-resistant Cam lock       |  $11.49 |
| Chain Holder Sheet Metal         |   $9.55 |
| Lid Wall Sheets 2in              |   $7.06 |
| Lid Wall Sheets 4in              |  $12.36 |
| 110VAC to 12VDC Power Supply     |  $12.99 |
| 12VDC to 5VDC USB Buck Converter |   $8.99 |
| Base channel                     |   $2.73 |
| Walls sheet metal                | $159.21 |
| Base sheet metal                 |  $86.97 |
| Relay                            |   $2.50 |
| Alarm                            |     5.5 |
| Barcode Scanner                  |      48 |
| Breakway Header Pins             |         |
| Hookup wire                      |         |

[Link to full BOM](https://docs.google.com/spreadsheets/d/1UFXavMa50xtnHM6pJ30hTJ9fhPLC3RiXioRj5jb3y0g/edit?usp=sharing)

## References
* Barcode reader datasheet
  * [Barcode_Scanner_Module_Setting_Manual_EN (1).pdf](https://github.com/khoatran2320/Senior-Design/files/8592588/Barcode_Scanner_Module_Setting_Manual_EN.1.pdf)
* Vibration Sensor datasheet
  * [Vibration-Sensor-Datasheet.pdf](https://github.com/khoatran2320/Senior-Design/files/8592589/Vibration-Sensor-Datasheet.pdf)
* LCD display library
  * [LCD-Display-Library](https://rplcd.readthedocs.io/en/stable/getting_started.html)
