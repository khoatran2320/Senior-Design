import 'package:flutter/material.dart';

class RoundedRectangle extends StatelessWidget {

	double width;
	String text;
	Color rectangleColor;
	Color textColor;
	bool isLowPercentage;

	RoundedRectangle(this.width, this.rectangleColor, {
		this.text = '', this.textColor = Colors.black, this.isLowPercentage = false
	});

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
			padding: isLowPercentage ? EdgeInsets.only(left: 10) : EdgeInsets.all(0),
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
