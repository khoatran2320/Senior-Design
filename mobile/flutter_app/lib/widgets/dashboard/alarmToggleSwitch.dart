import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'longRoundedRectangle.dart';
import 'shortRoundedRectangle.dart';

class AlarmToggleSwitch extends StatefulWidget {
	const AlarmToggleSwitch({Key? key}) : super(key: key);

	@override
	_AlarmToggleSwitchState createState() => _AlarmToggleSwitchState();
}

class _AlarmToggleSwitchState extends State<AlarmToggleSwitch> {

	static double _shortRectangleWidth = 80;
	static List<String> _toggleWords = ['OFF', 'ON'];
	bool _isOff = true;

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
	);

	void toggleSwitch() {
		setState(() {
			_isOff = !_isOff;
		});

		// TODO: Turn lock box alarm on/off.
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
