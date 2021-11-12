import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'longRoundedRectangle.dart';
import 'shortRoundedRectangle.dart';


class BatteryStatus extends StatefulWidget {
	const BatteryStatus({Key? key, this.batteryPercentage = 0}) : super(key: key);

	final double batteryPercentage;

	@override
	_BatteryStatusState createState() => _BatteryStatusState();
}

// TODO: Appearance of battery should change when battery percentage change.
// TODO: If percentage < 50%, % should appear on long rectange instead.
class _BatteryStatusState extends State<BatteryStatus> {

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
	);

	static const int batteryFullWidth = 150;

	@override
	Widget build(BuildContext context) {
		double _shortRectangleWidth = batteryFullWidth * widget.batteryPercentage;

		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				Text(
						'Battery',
						style: textStyle
				),
				SizedBox(height: 10),
				Stack(
					children: [
						LongRoundedRectangle(),
						Positioned(
							left: 0,
							child: ShortRoundedRectangle(_shortRectangleWidth, '90%', Color(0xff6DD7AF), Color(0xffF9FDFE))
						)
					],
				)
			]
		);
	}
}
