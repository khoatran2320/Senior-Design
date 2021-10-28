import 'package:flutter/material.dart';

class ShortRoundedRectangle extends StatelessWidget {

	double width;
	String text;
	Color rectangleColor;
	Color textColor;

	ShortRoundedRectangle(this.width, this.text, this.rectangleColor, this.textColor);

	@override
	Widget build(BuildContext context) {
		return Container(
			alignment: Alignment.center,
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(50),
				color: rectangleColor,
			),
			height: 50,
			width: width,
			child: Text(
				text,
				style: TextStyle(
					color: textColor,
					fontSize: 18,
					fontWeight: FontWeight.w500,
					height: 21/18
				),
			),
		);
	}
}
