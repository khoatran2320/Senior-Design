import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'longRoundedRectangle.dart';
import 'shortRoundedRectangle.dart';

class AlarmToggleSwitch extends StatefulWidget {
	const AlarmToggleSwitch({Key? key}) : super(key: key);

	@override
	_AlarmToggleSwitchState createState() => _AlarmToggleSwitchState();
}

// TODO: Implement state management in this widget. Clicking on the toggle
// should make toggle between on/off.
class _AlarmToggleSwitchState extends State<AlarmToggleSwitch> {

	@override
	Widget build(BuildContext context) {

		double _shortRectangleWidth = 80;
		const _toggleWords = ['OFF', 'ON'];
		int _index = 0;
		double? _left = 0;
		double? _right = null;

		final TextStyle textStyle = TextStyle(
			color: Color(0xffF9FDFE),
			fontSize: 18,
			fontWeight: FontWeight.w500,
		);

		void toggleSwitch() {
			// setState(() {
			// 	_index = (_index == 0) ? 1 : 0;
			// 	_left = (_left == null) ? 0 : null;
			// 	_right = (_right == null) ? 0 : null;
			// });

			print('_index $_index, _left $_left, _right $_right');
		}

		return Column(
			mainAxisSize: MainAxisSize.min,
			// mainAxisAlignment: MainAxisAlignment.start,
			children: [
				GestureDetector(
					onTap: () {
						toggleSwitch();
						print('Tapped alarm toggle');
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
									LongRoundedRectangle(),
									Positioned(
										left: _left,
										right: _right,
										child: ShortRoundedRectangle(_shortRectangleWidth, _toggleWords[_index], Color(0xffF9FDFE), Color(0xffED6971))
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
