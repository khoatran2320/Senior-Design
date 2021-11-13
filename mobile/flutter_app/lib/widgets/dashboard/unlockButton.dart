import 'package:flutter/material.dart';

import '/utils/colors.dart';

// TODO: Pass isLocked parameter.
class UnlockButton extends StatefulWidget {
	final bool isLocked;
	const UnlockButton({ Key? key, this.isLocked = true }) : super(key: key);

	@override
	_UnlockButtonState createState() => _UnlockButtonState();
}

class _UnlockButtonState extends State<UnlockButton> {

	bool isLocked = true;

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500
	);

	void initState() {
		super.initState();
		isLocked = widget.isLocked;
	}

	void unlock() {
		setState(() {
			isLocked = false;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisSize: MainAxisSize.min,
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
							width: 150
						),
						GestureDetector(
							onTap: () {
								unlock();
							},
							child: Icon(
								isLocked ? Icons.lock : Icons.lock_open,
								color: Color(0xffE4FCF9),
								size: 60
							),
						),
					],
				),
				TextButton(
					child: Text(
						isLocked
							? 'Tap to Unlock'
							: 'Close the box lid to lock it.',
						style: textStyle
					),
					onPressed: () {
						isLocked ? unlock() : null;
					}
				)
			]
		);
	}
}
