import 'package:flutter/material.dart';

class LongRoundedRectangle extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(50),
				color: Color(0xffD8F2EA),
			),
			height: 50,
			width: 150,
		);
	}
}
