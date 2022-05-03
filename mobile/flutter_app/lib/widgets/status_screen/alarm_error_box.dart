import 'package:flutter/material.dart';

class AlarmErrorBox extends StatelessWidget {
	AlarmErrorBox(this.error);

  final String error;

	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: [
				Text(
					'Error'
				),
				Text(
					error
				),
				ElevatedButton(
					onPressed: () {
						Navigator.pop(context);
					},
					child: const Text('OK'),
				)
			]
		);
	}
}
