# Dev / Build Tool Information
### Mobile
- Flutter 2.10.4
- Android Studio 2020.3.1
- Android SDK API = 31
- Apple Simulator 2.5.1 (iPhone 12 Pro Max) OR
- Android Emulator (Pixel API 29 Android 10)
### Server
- Latest versions of Node.js & npm

# Software Modules Overview
## BOXi Modules
### app.py

Flask server.  

Contains:
- Server routes
- Server scripts

Depends on:
- `get_box_user_id()`
- `get_node_server_ip()`
- `Flask`
- `request`
- `jsonify`
- `trip()`
- `beep()`
- `get_ip_addr`
- `LCD_disp()`

### file_utils.py

Utility functions to read and write to file.  

Contains:
- `read_txt_file(filename)`: read from file given by `filename`.
- `write_txt_file(filename, content)`: write `content` to `filename`.

### get_box_user_id.py

Function to retrieve the box ID and the user ID associated with the box. 

Contains:
- `get_box_user_id()`: returns the box ID user ID.

Depends on:
- `read_txt_file()`

### get_node_server_ip.py

Function to retrieve the IP address of the Node server.

Contains:
- `get_node_server_ip()`: return the IP address of the Node server.

Depends on:
- `read_txt_file`

### beeper.py

GPIO interaction with the alarm. 

Contains:
- `beep(iterations=1, post_url=None)`: turns on the alarm that beeps once every 500ms for `iterations` iterations and posts the status of the alarm to the URl `post_url`.

Depends on:
- `GPIO`
- `time`
- `requests`
- `get_ip_addr()`
- `LCD_disp()`


### config_wifi.py

Configures the wifi.

Contains:
- `config_wifi(ssid, pwd)`: writes wifi details `ssid` and `pwd` to system network config files.

Depends on:
- `os`

### get_ip_addr.py

Retrieves the IP address of the box. 

Contains:
- `get_ip_addr()`: returns the IP address. 

Depends on:
- `socket`

### lcd.py

LCD display interaction.

Contains:
- `LCD_disp(str_in)`: Displays the text `str_in` on the LCD display.

Depends on:
- `CharLCD`

### lock_is_trip.py

Lock trip status interaction. 

Contains:
- `is_trip(post_url=None)`: Monitors the lock status and posts to `post_url` when there's a change in status.

Depends on:
- `GPIO`
- `sleep()`
- `requests`
- `get_ip_addr()`

### loop_scanner.py

Barcode scanner interaction.

Contains:
- `readData()`: Returns the ascii decoded scanned barcode. 
- `parse_barcode(barcode)`: Parses the barcode and returns wifi user name and password if the barcode contains it else returns 'tracking' and '#' to denote a tracking number barcode.
- `loop_scanner(post_url=None)`: Monitors the barcode scanner and either validates relays the tracking number to the Flask server or config the wifi. 

Depends on:
- `serial`
- `requests`
- `get_ip_addr()`
- `config_wifi()`
- `LCD_disp()`

### trip_lock.py

GPIO lock interaction.

Contains:
- `trip()`: Unlocks the lock. 

Depends on:
- `GPIO`
- `sleep()`

### vibration.py

GPIO vibration sensor interaction. 

Contains:
- `loop_vib(it=20, post_url=None)`: Monitors the vibration sensor and turns on the alarm if the vibration sensor trips `it` times. 

Depends on:
- `GPIO`
- `sleep()`
- `beep()`
- `get_ip_addr()`

## Package management routes
![mobile_diagram](https://user-images.githubusercontent.com/48025259/158888516-efcc7081-0b33-4a20-aae4-1e3bfe57f440.png)

### GET `/package/`

Retrieves the package information for a given package tracking number belonging to a user.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| trackingNumber | String    | Yes       | The package tracking number to get details for.  

| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Package information in JSON format.
| 400            | Failure   | Error message.  


### GET `/package/all`

Retrieves the package information for all packages belonging to a user.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   


| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Package information in JSON format.
| 400            | Failure   | Error message.  


### POST `/package/`

Adds a package given by its tracking number to start tracking under a user.

| Parameter      | Type      | Required?                         |Description 
| -------------  | --------- | --------------------------------- | ----------- | 
| userId         | String    | Yes                               | The unique identifier associated with each registerred user.   
| trackingNumber | String    | Yes                               | The package tracking number to add to the user.  
| itemName       | String    | No                                | Name of the package.  
| merchantName   | String    | No                                | Name of vendor.  
| orderNumber    | String    | Yes if `merchantName` is `amazon` | Amazon order number.  

| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Success message.
| 400            | Failure   | Error message.  

### POST `/package/update`

Requests an update of the package information.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| trackingNumber | String    | Yes       | The package tracking number to request an information update for.  


| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Success message.
| 400            | Failure   | Error message.  

### DELETE `/package/`

Delete a package from being tracked belonging to a user.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| trackingNumber | String    | Yes       | The package tracking number to delete.  


| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Success message.
| 400            | Failure   | Error message.  


## BOXi management routes
![mobile_diagram](https://user-images.githubusercontent.com/48025259/158888466-2b04163a-603e-4b44-8f65-1a55c152b0c2.png)

### GET `/boxi/package`

Checks to see if a package tracking number is expected to be delivered.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.
| trackingNumber | String    | Yes       | The package tracking number to validate.  


| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Success message.
| 400            | Failure   | Error message.  

### POST `/boxi/add-box`

Adds a link between a user and a box.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.


| Return code    | Type      | Load 
| -------------  | --------- | ----------- | 
| 200            | Success   | Success message.
| 400            | Failure   | Error message.  


### POST `/boxi/delivery`

Mark the status of a package as delivered.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.
| trackingNumber | String    | Yes       | The package tracking number to confirm delivery for.  

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Success message.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


### POST `/boxi/unlock`

Mark the status of the box as unlocked or locked.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.
| isUnlocking    | Boolean   | Yes       | Whether the box is unlocked or locked.  

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Success message.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


### GET `/boxi/unlock-status`

Retrieves the lock status of the box.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Lock status in JSON format.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


### POST `/boxi/alarm`

Mark the status of the box alarm as on or off.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.
| isAlarming     | Boolean   | Yes       | Whether the box alarm is on or off.  

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Success message.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


### GET `/boxi/alarm-status`

Retrieves the alarm status of the box.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Alarm status in JSON format.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


### POST `/boxi/post-ip`

Posts the IP address and port of the BOXi server.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.
| ipAddr         | String    | Yes       | The IP address of the BOXi server.
| port           | String    | Yes       | The port of the BOXi server.

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Success message.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  



## Mobile management routes

### POST `/mobile/unlock-box`

Unlocks the box belonging to a user.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Success message.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


### POST `/mobile/signal-alarm`

Turns on the box alarm.

| Parameter      | Type      | Required? |Description 
| -------------  | --------- | --------- | ----------- | 
| userId         | String    | Yes       | The unique identifier associated with each registerred user.   
| boxiId         | String    | Yes       | The unique identifier associated with each box.

| Return code    | Type              | Load 
| -------------  | ---------         | ----------- | 
| 200            | Success           | Success message.
| 400            | Failure           | Error message.  
| 403            | Access fobidden   | Error message.  


## BOXi server routes

### POST `/barcode`

Receives a barcode and makes an external request to validate it.

| Parameter      | Type      | Description 
| -------------  | --------- | ----------- | 
| barcode        | String    | The scanned package tracking number.

| Case           | Subsequent steps  | 
| -------------  | ---------         |
| Success        | Validate package, unlock box, post lock status, print to LCD display.
| Failure        | Print to LCD display.

### POST `/lock-status`

Receives a lock status and makes an external request to post it to the database.

| Parameter      | Type      | Description 
| -------------  | --------- | ----------- | 
| lockStatus     | Boolean   | The lock status.

| Case           | Subsequent steps  | 
| -------------  | ---------         |
| Success        | Post status
| Failure        | 

### POST `/alarm-status`

Receives an alarm status and makes an external request to post it to the database.

| Parameter      | Type      | Description 
| -------------  | --------- | ----------- | 
| alarmStatus    | Boolean   | The alarm status.

| Case           | Subsequent steps  | 
| -------------  | ---------         |
| Success        | Post status
| Failure        | 

## Mobile Modules (Flutter Widgets)
![mobile_diagram](https://user-images.githubusercontent.com/56775136/166072081-bb515f17-a4ee-4200-9c6b-5085ff6dfb6f.png)

#### MaterialApp
Generic app widget that sets a specific widget (i.e. Splash) as the homescreen.

#### Splash
This is the splash screen of the app. The user will only see it after downloading the app. After that the splash screen will just redirect the user to the SignIn screen.

#### SignIn
This is where the user signs in by filling out their email and password. Tapping on “Don’t have an account?” will redirect the user to the SignUp screen for creating an account. Tapping on the “Sign In” button will redirect the user to the Dashboard screen, unless the login information is entered incorrectly.

#### SignUp
This is where the user signs up for an account by filling out their email, name, and password. Tapping on the “Sign Up” button will redirect the user back to the SignIn screen.

#### Dashboard
This is the screen for navigating between SettingsPage, StatusScreen, and DeliveriesScreen. The screen consists of DashboardTop, TabBar, and TabBarView. 

#### DashboardTop
This is the top portion of the Dashboard screen. It consists of a circular avatar and a welcome message for the user. Tapping on the circular avatar will take the user to the SettingsScreen.

#### TabBar
This is the bar that divides DashboardTop and TabBarView. It has two tabs: “Status” and “Deliveries.” Tapping on the Status tab will display the StatusScreen within TabBarView. Tapping on the Deliveries tab will display the DeliveriesScreen within TabBarView.

#### TabBarView
This is the segment of the Dashboard under the TabBar. It will either display DeliveriesScreen or StatusScreen, depending on which tab that the user tapped on in the TabBar.

#### SettingsPage
It has a “Back” button and a “Log Out” button. Tapping on “Back” will bring the user back to the Dashboard. Tapping on “Log Out” will redirect the user to the SignIn screen.

#### StatusScreen
It consists of an UnlockButton, AlarmToggleSwitch, and SetupButton.

#### UnlockButton
Tapping on the UnlockButton will wirelessly unlock the physical lockbox.

#### AlarmToggleSwitch
Tapping on the AlarmToggleSwitch will enable/disable the alarm of the physical lockbox.

#### SetupButton
Tapping on the SetupButton will bring up the SetupDialog.

#### SetupDialog
It will show a series of dialogs. The first dialog is the confirmSetupDialog. It asks the user to confirm that they want to start the setup process. Once the user confirms, the next dialog is a form for filling out WiFi username and password. Once the form is submitted, the next dialog is a QR code. Use the barcode scanner of BOXi to scan this QR code. This will send the WiFi login information to BOXi so that it could connect to WiFi.

#### DeliveriesScreen
This is the screen for tracking the delivery status of packages. The user could start tracking a package by entering the tracking number, name, and merchant of the package. Each added package will have a package status card showing the delivery status. They could also stop tracking a package by deleting the corresponding package status card. 


