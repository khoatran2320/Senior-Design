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
	const AlarmToggleSwitch({Key? key}) : super(key: key);

	@override
	_AlarmToggleSwitchState createState() => _AlarmToggleSwitchState();
}

class _AlarmToggleSwitchState extends State<AlarmToggleSwitch> {

	static double _longRectangleWidth = 150;
	static double _shortRectangleWidth = 80;
	static List<String> _toggleWords = ['OFF', 'ON'];
	bool _isOff = true;

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
	);

	void toggleSwitch(context) async {
		// TODO: Update hardcoded uri and boxiId to dynamically fetched versions
		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = "${serverUrl}/mobile/signal-alarm";
		String boxiId = "boxi_prototype_00000";

		bool willBeOn = _isOff;
		String alarmStatus = willBeOn ? "on" : "off";

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
			print('Toggled the alarm switch.');
			setState(() {
				_isOff = !_isOff;
			});
		}
		else {
			print('Error for toggling the alarm switch: $responseBody');
			_showErrorBox(context, '$responseBody');
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

		double? _left = _isOff ? 0 : null;
		double? _right = _isOff ? null : 0;
		int _index = _isOff ? 0 : 1;

		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				GestureDetector(
					onTap: () {
						toggleSwitch(context);
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
