# BOXi
<div id="top"></div>
Mella Liang, Daniel Gruspier, Yan Chen, Khoa Tran, Kenneth Chan


<!-- PROJECT LOGO -->
## About the Project

BOXi is a senior design project completed to fulfill the undergraduate degree requirement at Boston University's College of Engineering. This project was completed during the school year 2021-2022. 
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#user-stories">User Stories</a>
    </li>
    <li>
      <a href="#architecture">Architecture</a>
      <ul>
        <li><a href="#software">Software</a></li>
        <li><a href="#hardware">Hardware</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#mobile-setup">Mobile setup</a></li>
        <li><a href="#node-server-setup">Node server setup</a></li>
        <li><a href="#flask-server-setup">Node server setup</a></li>
      </ul>
    </li>
    <li>
      <a href="#documentation">Documentation</a>
    </li>
    <li>
      <a href="#tests">Tests</a>
    </li>
  </ol>
</details>

<br />
<div>
<h2>Problem Statement</h2>
<p>
There is no economical consumer solution to the issue of porch package theft that integrates delivery tracking and reception. An ideal solution, which is not yet available, would offer physical storage of deliveries that is impenetrable to tampering, informs the owner about the status of both the receptacle and its contents, synchronizes with delivery tracking services, and only allows access to its contents by the recipient and those mailpersons making deliveries to that recipient. Our solution aims to provide consumers with a secure anti-theft package box that approaches these features. The anti-theft package box, named “BOXi”, will integrate with tracking services and be resistant to unauthorized access, simple to use, and economical. 
<br />
  </p>


<p align="right">(<a href="#top">back to top</a>)</p>

<h2>Deliverables</h2>
<p >
Our design will consist of a durable lock box to be installed on the exterior of a home near the front door. BOXi can be secured to the consumer’s home in different ways, allowing for flexibility. First, it can be chained to the home similar to how a bike can be chained to a post to prevent theft. Second, BOXi will allow the user to add additional sand that will increase the overall weight of the lock box to 150lbs, making it very difficult to be stolen. Finally, BOXi can be anchored directly to the porch floor by bolting it to drilled holes in the concrete. These mechanisms will allow the lock box to be safely secured at the user’s home while housing the packages. 

BOXi has a unique authorization mechanism that only allows access to the intended user. The consumer can directly open the box from their phones that are connected to BOXi. Additionally, the user can open the box with a key that does not require power or a mobile device to operate. BOXi has a barcode scanner that will allow delivery personnel access once an expected package is scanned. 

Our solution also comes with a mobile application that will accompany the lock box. Both the lock and the mobile device require internet connection, and the two work in tandem to further increase security of the user’s packages. Whenever a user makes a purchase online and expects a delivery, our system will analyze the user’s email and automatically add the item’s tracking number to the list of expected packages to be delivered. These items will serve as keys for the delivery personnel to open BOXi. The mobile application also displays the status of packages, including shipping and delivery updates. Additionally, the user will receive live status updates of the box, including when the box is open and when a delivery has been completed. 
<br />
</p>
</div>
<p align="right">(<a href="#top">back to top</a>)</p>



## User Stories

1. User can log in to mobile app to add a package to track, view the status of tracked packages, and delete a package from being tracked. 
2. User can unlock BOXi from the mobile app. 
3. User is notified of package deliveries. 
4. User is notified when BOXi is being tampered with. 
5. Delivery personel can scan an expected package to open BOXi. 

<p align="right">(<a href="#top">back to top</a>)</p>

## Architecture

### Software
![Blank diagram (1)](https://user-images.githubusercontent.com/48025259/158888516-efcc7081-0b33-4a20-aae4-1e3bfe57f440.png)

![Blank diagram](https://user-images.githubusercontent.com/48025259/158888466-2b04163a-603e-4b44-8f65-1a55c152b0c2.png)
### Hardware
<!-- GETTING STARTED -->
## Getting Started

The whole system includes a Flask server running on the Raspberry Pi, a Node server running on any machine, and a mobile application. It also depends on Google Firebase Authentication and Firestore.  

BOXi uses a third party package manager from pkge.net. 

To clone this repository:
```
git clone https://github.com/khoatran2320/Senior-Design.git
```
### Mobile setup
1. Install Flutter 2.5.3
2. Install a simulator OR use a physical device:
    - Android studio with emulator support for Android SDK 31
    - Xcode with emulator support for IOS versions greater than 13
    - Android phone
    - iPhone with IOS version greater than 13
3. Navigate to mobile app directory:
```
cd mobile/flutter_app
``` 
4. Install package dependencies:
```
flutter pub get
```
5. Open simulator
6. Click run as debug (Android) or for IOS:
```
flutter run
```
<p align="right">(<a href="#top">back to top</a>)</p>

### Node server setup
1. Install the latest version of Node
2. Navigate to server directory:
```
cd server
```
3. Install dependencies:
```
sudo npm install
```
4. Obtain Google Firebase service account key
5. Obtain pkge.net developer API key
6. To run server:
```
node src/index.js
```

<p align="right">(<a href="#top">back to top</a>)</p>

### Flask server setup
1. Install Python version 3.8 with pip
2. Navigate to the BOXi server:
```
cd boxi/server
```
3. Install Flask:
```
pip install flask
```
4. Run the Flask server:
```
python app.py
```
<p align="right">(<a href="#top">back to top</a>)</p>

<!-- DOCUMENTATION  -->
## Documentation  

Documentation

<p align="right">(<a href="#top">back to top</a>)</p>

## Tests  
Tests
<p align="right">(<a href="#top">back to top</a>)</p>

## Mobile App Prototype
<img width="242" alt="Screen Shot 2021-10-14 at 4 07 10 PM" src="https://user-images.githubusercontent.com/48025259/137387989-4f1054e0-72ef-4d3e-bbad-a74b3755c915.png">


<img width="232" alt="Screen Shot 2021-10-14 at 4 07 00 PM" src="https://user-images.githubusercontent.com/48025259/137388069-dd229399-a92b-4df9-ba3c-9d483f5c0eae.png">

## Hardware Prototype
![CDR Model(2)](https://user-images.githubusercontent.com/60275153/158884474-a6f0bfe5-ca8b-44ff-82c2-83fb2ed2f794.png)
