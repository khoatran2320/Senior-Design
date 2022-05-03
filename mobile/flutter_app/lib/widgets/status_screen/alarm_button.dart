import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '/utils/colors.dart';

final serverUrl = dotenv.env['SERVER_URL'];

class AlarmButton extends StatefulWidget {
	const AlarmButton({Key? key}) : super(key: key);

	@override
	_AlarmButtonState createState() => _AlarmButtonState();
}

class _AlarmButtonState extends State<AlarmButton> {

	void triggerAlarm() async {
		// TODO: Update hardcoded uri and boxiId to dynamically fetched versions
		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = "${serverUrl}/mobile/signal-alarm";
		String boxiId = "boxi_prototype_00000";
		String alarmStatus = "on";

		Map data = {
			'userId': userId,
			'boxiId': boxiId,
			'alarmStatus': alarmStatus
		};

		var body = json.encode(data);

		var response = await http.post(
			Uri.parse(uri),
      headers: {
				'Content-Type': 'application/json;charset=UTF-8',
				'Charset': 'utf-8'
			},
      body: body
	  );

		var responseBody = response.body;

		if (response.statusCode == 200) {
			print('Triggered the alarm!');
		}
		else {
			print('Error: $responseBody');
		}
	}

	@override
	Widget build(BuildContext context) {

		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				Stack(
					alignment: Alignment.center,
					children: [
						Container(
							decoration: BoxDecoration(
								color: Color(0xff6DD7AF),
								shape: BoxShape.circle
							),
							height: 80,
							width: 80
						),
						GestureDetector(
							onTap: () {
								triggerAlarm();
							},
							child: Icon(
								Icons.notifications,
								color: Color(0xffE4FCF9),
								size: 60
							)
						)
					]
				)
			]
		);

		// return Column(
		// 	mainAxisSize: MainAxisSize.min,
		// 	children: [
		// 		GestureDetector(
		// 			onTap: () {
		// 				triggerAlarm();
		// 			},
		// 			child: Icon(
		// 				Icons.notifications,
		// 				color: Color(0xff6DD7AF),
		// 				size: 60
		// 			),
		// 		)
		// 	],
		// );
	}
}
