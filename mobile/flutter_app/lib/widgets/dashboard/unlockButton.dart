import 'package:flutter/material.dart';

import '/utils/colors.dart';


class UnlockButton extends StatefulWidget {
	const UnlockButton({Key? key}) : super(key: key);

	@override
	_UnlockButtonState createState() => _UnlockButtonState();
}

class _UnlockButtonState extends State<UnlockButton> {

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
		// height: 21
	);

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			// mainAxisAlignment: MainAxisAlignment.start,
			children: [
				Stack(
					alignment: Alignment.center,
					children: [
						Container(
							decoration: BoxDecoration(
		            color: Color(0xff6DD7AF),
		            shape: BoxShape.circle
		          ),
							height: 150,
							width: 150,
							// margin: const EdgeInsets.only(bottom: 20)
						),
						Icon(
							Icons.lock,
							color: Color(0xffE4FCF9),
							size: 60
						)
					],
				),
				TextButton(
					child: Text(
						'Tap to Unlock',
						style: textStyle
					),
					onPressed: () {
						print('unlock button pressed');
					}
				)
			]
		);
	}
}
