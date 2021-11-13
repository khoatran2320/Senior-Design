import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'roundedRectangle.dart';


class BatteryStatus extends StatelessWidget {

	BatteryStatus(this.batteryPercentage);

	final double batteryPercentage;

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
	);

	static const double _batteryFullWidth = 150;

	@override
	Widget build(BuildContext context) {
		double appearancePadding = getAppearancePadding(batteryPercentage);
		double _shortRectangleWidth
			= _batteryFullWidth * batteryPercentage + appearancePadding;
		String percentageText = (batteryPercentage * 100).round().toString() + '%';

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
						RoundedRectangle(
							_batteryFullWidth,
							Color(0xffD8F2EA),
							text: (batteryPercentage <= .2) ? percentageText : '',
							textColor: Colors.black, isLowPercentage: true
						),
						Positioned(
							left: 0,
							child: RoundedRectangle(
								_shortRectangleWidth,
								Color(0xff6DD7AF),
								text: (batteryPercentage > .2) ? percentageText : '',
								textColor: Color(0xffF9FDFE)
							)
						)
					],
				)
			]
		);
	}
}

// Manual adjustments for the appearance of the battery status bar
double getAppearancePadding(percentage) {
	if (percentage >= .6) return 0;
	if (percentage > .4) return 10;
	if (percentage > .3) return 20;
	if (percentage > .2) return 23;
	return 25;
}
