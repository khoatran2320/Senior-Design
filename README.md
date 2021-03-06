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
Our design will consist of a durable lock box to be installed on the exterior of a home near the front door. BOXi can be secured to a railing, post, or other permanent fixture of the user’s home via a chain lock (such as a bike lock) or padlock thanks to an attachment fixture on the side of BOXi. These mechanisms will allow the lock box to be safely secured at the user’s home while housing the packages. 

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
<img width="645" alt="Screen Shot 2022-03-17 at 4 25 13 PM" src="https://user-images.githubusercontent.com/48025259/158889342-66159f1c-9fa2-44cc-b1e9-23270608d2ce.png">

### Hardware
![Electronics Block Diagram V1 1(5)](https://user-images.githubusercontent.com/60275153/158902174-5647bae7-ebba-4890-bb5b-7def9b6403e1.png)

BOXi is powered from standard 120VAC wall power. Power on BOXi by plugging it into an outlet via the plug insert on the left side of the lid. A grounded outlet must be used. Mount BOXi to a railing, post, or other permanent fixture by looping a chain lock (such as a bike lock) or padlock through the attachment fixture on the back side of the casing. The entire casing of BOXi is constructed from 6061 grade aluminum or various thickness. The attachment fixture is constructed from 0.05in. thick 3000 grade aluminum.

Inside the lid of BOXi, there is a power supply (PS) that converts 120VAC to 12VDC. There is also a buck converter that converts 12VDC from the PS to 5VDC on a USB connection to power the Raspberry Pi. 12VDC from the PS is also routed through a relay to actuate an electronic lock. This lock keeps BOXi closed.

BOXi can be opened by two methods.
1.) Via the mobile app (see Architecture, Software).
2.) Via a mechanical lock located on the front of the lid. Insert the provided key into the keyhole and turn counterclockwise. Doing so will cause a cam inside the keyhole to make contact with a mechanical release on the electronic lock.
WARNING: The lid is attached to the casing by spring-loaded hinges. Keep hands clear of the lid when opening BOXi to prevent injury.

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
5. Register Firebase project, and register an android app and an iOS app for the project. Obtain the `google-services.json` and `GoogleService-Info.plist` files and place them in the correct directory listed on Firebase documentation [ios](https://firebase.google.com/docs/ios/setup), [android](https://firebase.google.com/docs/android/setup).  
6. Open simulator
7. Click run as debug (Android) or for IOS:
```
flutter run
```
<p align="right">(<a href="#top">back to top</a>)</p>

### pkge.net set up

1. Sign up for a business account at business.pkge.net.
2. Navigate to `Developers` then to `API key`.
3. Create a file in `server/src/` directory called `.env`.
4. Write to `.env` `PKGE_API_KEY={api key}`.

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
  - Register for Firebase console account
  - Create an web application project
  - Follow the docs listed [here](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) to generate a private service account key, and name it as `boxi_key.json`, and place this file in `server/src` directory.
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

![Blank diagram (1)](https://user-images.githubusercontent.com/48025259/158888516-efcc7081-0b33-4a20-aae4-1e3bfe57f440.png)

![Blank diagram](https://user-images.githubusercontent.com/48025259/158888466-2b04163a-603e-4b44-8f65-1a55c152b0c2.png)

<p align="right">(<a href="#top">back to top</a>)</p>


## Mobile App Prototype
<img width="242" alt="Screen Shot 2021-10-14 at 4 07 10 PM" src="https://user-images.githubusercontent.com/48025259/137387989-4f1054e0-72ef-4d3e-bbad-a74b3755c915.png">


<img width="232" alt="Screen Shot 2021-10-14 at 4 07 00 PM" src="https://user-images.githubusercontent.com/48025259/137388069-dd229399-a92b-4df9-ba3c-9d483f5c0eae.png">

## Hardware Prototype
![CDR Model(2)](https://user-images.githubusercontent.com/60275153/158884474-a6f0bfe5-ca8b-44ff-82c2-83fb2ed2f794.png)

## Bill of Materials
[Bill of Materials PDF](https://github.com/khoatran2320/Senior-Design/blob/master/BOXi_BOM_-_Sheet2.pdf)
