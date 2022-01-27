import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../widgets/dashboard/alarm_toggle_switch.dart';
import '../widgets/dashboard/unlock_button.dart';


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
			child: Stack(
				alignment: Alignment.topCenter,
				children: [
					Positioned(
						top: 60,
						child: UnlockButton(isLocked: true)
					),
					Positioned(
						bottom: 125,
						left: 25,
						child: AlarmToggleSwitch()
					)
				],
			),
		);
	}
}
