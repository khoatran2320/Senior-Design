import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../widgets/dashboard/alarmToggleSwitch.dart';
import '../widgets/dashboard/batteryStatus.dart';
import '../widgets/dashboard/unlockButton.dart';


class StatusScreen extends StatefulWidget {
	const StatusScreen({Key? key}) : super(key: key);

	@override
	_StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
		height: 21
	);

	@override
	Widget build(BuildContext context) {
		return Container(
			color: Color(0xffB7E7D5),
			child: Stack(
				alignment: Alignment.topCenter,
				children: [
					Positioned(
						top: 60,
						child: UnlockButton()
					),
					Positioned(
						bottom: 125,
						left: 25,
						child: AlarmToggleSwitch()
					),
					Positioned(
						bottom: 125,
						right: 25,
						child: BatteryStatus(batteryPercentage: 0.9)
					)
				],
			),
		);
	}
}
