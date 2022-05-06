import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '/utils/colors.dart';
import 'rounded_rectangle.dart';
import 'alarm_error_box.dart';

final serverUrl = dotenv.env['SERVER_URL'];

class AlarmToggleSwitch extends StatefulWidget {

	final bool isOff;
	final Function getAlarmStatus;

	const AlarmToggleSwitch(this.isOff, this.getAlarmStatus, {Key? key}) : super(key: key);

	@override
	_AlarmToggleSwitchState createState() => _AlarmToggleSwitchState();
}

class _AlarmToggleSwitchState extends State<AlarmToggleSwitch> {

	static double _longRectangleWidth = 150;
	static double _shortRectangleWidth = 80;
	static List<String> _toggleWords = ['OFF', 'ON'];

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
	);

	void toggleSwitch(context, isOff, getAlarmStatus) async {
		// TODO: Update hardcoded uri and boxiId to dynamically fetched versions
		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String boxiUri = "$serverUrl/mobile/signal-alarm";
		String backendUri = "$serverUrl/mobile/alarm-enable";
		String boxiId = "boxi_prototype_00000";

		bool willBeOn = isOff;
		String alarmStatus = willBeOn ? "on" : "off";

		Map data = {
			'userId': userId,
			'boxiId': boxiId,
			'alarmStatus': alarmStatus, // For boxi api call
			'alarmEnable': alarmStatus // For database api call
		};

		var body = json.encode(data);

		var boxiResponse = await http.post(
			Uri.parse(boxiUri),
      headers: {
				'Content-Type': 'application/json;charset=UTF-8',
				'Charset': 'utf-8'
			},
      body: body
	  );

		var boxiResponseBody = boxiResponse.body;

		if (boxiResponse.statusCode == 200) {
			var backendResponse = await http.post(
				Uri.parse(backendUri),
	      headers: {
					'Content-Type': 'application/json;charset=UTF-8',
					'Charset': 'utf-8'
				},
	      body: body
		  );

			if (backendResponse.statusCode == 200) {
				print('Toggled the alarm switch.');
				getAlarmStatus();
			} else {
				var backendResponseBody = backendResponse.body;
				print('Backend server error for toggling the alarm switch: $backendResponseBody');
				_showErrorBox(context, 'Failed to toggle alarm switch due to backend server error.');
			}
		}
		else {
			print('BOXi error for toggling the alarm switch: $boxiResponseBody');
			_showErrorBox(context, 'Failed to toggle alarm switch due to BOXi server error.');
		}
	}

	void _showErrorBox(context, error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 120,
            child: AlarmErrorBox(error)
          )
        );
      }
    );
  }

	@override
	Widget build(BuildContext context) {

		bool isOff = widget.isOff;
		double? _left = isOff ? 0 : null;
		double? _right = isOff ? null : 0;
		int _index = isOff ? 0 : 1;

		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				GestureDetector(
					onTap: () {
						print('Tapped alarm switch');
						toggleSwitch(context, isOff, widget.getAlarmStatus);
					},
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							Text(
									'Alarm',
									style: textStyle
							),
							SizedBox(height: 10),
							Stack(
								children: [
									RoundedRectangle(_longRectangleWidth, Color(0xffD8F2EA)),
									Positioned(
										left: _left,
										right: _right,
										child: RoundedRectangle(
											_shortRectangleWidth,
											Color(0xffF9FDFE),
											text: _toggleWords[_index],
											textColor: Color(0xffED6971)
										),
									)
								],
							),
						]
					)
				)
			],
		);
	}
}
