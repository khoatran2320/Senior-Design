## Package management routes

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
