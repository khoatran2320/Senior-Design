import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '/utils/colors.dart';
import '../widgets/status_screen/alarm_toggle_switch.dart';
import '../widgets/status_screen/unlock_button.dart';
import '../widgets/status_screen/setup_button.dart';

final serverUrl = dotenv.env['SERVER_URL'];

class StatusScreen extends StatefulWidget {
	const StatusScreen({Key? key}) : super(key: key);

	@override
	_StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

	bool alarmIsOff = true;

	void initState() {
		getAlarmEnabledStatus();
	}

	void getAlarmEnabledStatus() async {

		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String boxiId = "boxi_prototype_00000";
		String uri = "$serverUrl/mobile/alarm-enable?userId=$userId&boxiId=$boxiId";

    final response = await http.get(Uri.parse(uri));

		if (response.statusCode == 200) {

			String enabled = jsonDecode(response.body)["data"];
			bool isOff = (enabled == "off") ? true : false;

			print('Alarm enabled: $enabled');

			setState(() {
				alarmIsOff = isOff;
			});

		} else {
			var error = response.body;
			print('Error $error');
		}
	}

	@override
	Widget build(BuildContext context) {
		
		return Container(
			color: Color(0xffB7E7D5),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: [
					UnlockButton(isLocked: true),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						crossAxisAlignment: CrossAxisAlignment.end,
						children: [
							AlarmToggleSwitch(alarmIsOff, getAlarmEnabledStatus),
							Align(
				        alignment: Alignment.bottomCenter,
				        child: SetupButton(),
				      ),
						]
					)
				],
			),
		);
	}
}
