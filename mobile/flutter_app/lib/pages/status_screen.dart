import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../widgets/status_screen/alarm_button.dart';
import '../widgets/status_screen/unlock_button.dart';
import '../widgets/status_screen/setup_button.dart';


class StatusScreen extends StatefulWidget {
	const StatusScreen({Key? key}) : super(key: key);

	@override
	_StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

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
						children: [
							AlarmButton(),
							SetupButton()
						]
					)
				],
			),
		);
	}
}
