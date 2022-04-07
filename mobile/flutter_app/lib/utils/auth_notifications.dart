// src: https://firebase.flutter.dev/docs/messaging/notifications/
import "dart:async";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '/models/lock_model.dart';


Future<void> firebaseMessagingForegroundHandler(RemoteMessage message, BuildContext context) async {
	var isLocked = !(message.data['unlock_status'] == 'true');

	// Only update lock model when unlocked => locked
	// if (isLocked) {
	// 	Provider.of<LockModel>(context, listen: false).update(true);
	// }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
	print("background notif");

	RemoteNotification? notification = message.notification;

	if (notification == null) return;

	print('notification $notification');

}

Future<void> initializeNotification() async {
  try {
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  } catch(e) {
  	print(e.toString());
  }
}

// Future<void> showAndroidNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails('your channel id', 'your channel name',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker');
//
//   const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin.show(
//     0, 'plain title', 'plain body', platformChannelSpecifics,
//     payload: 'item x');
// }

// Future<void> createAndroidNotificationChannel() async {
//
// 	const AndroidNotificationChannel channel = AndroidNotificationChannel(
// 	  'high_importance_channel', // id
// 	  'High Importance Notifications', // name
// 	  description: 'This channel is used for important notifications.',
// 	  importance: Importance.max,
// 	);
//
// 	await flutterLocalNotificationsPlugin
// 	  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
// 	  ?.createNotificationChannel(channel);
// }
