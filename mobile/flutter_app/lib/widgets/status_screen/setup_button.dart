import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'rounded_rectangle.dart';
import 'setup_dialog.dart';


class SetupButton extends StatelessWidget {
  const SetupButton({Key? key}) : super(key: key);

	static double _buttonWidth = 150;

	final TextStyle textStyle = const TextStyle(
		color: const Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500,
	);

	void _showSetupDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 400,
            child: SetupDialog()
          )
        );
      }
    );
  }

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				GestureDetector(
					onTap: () {
						_showSetupDialog(context);
					},
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							RoundedRectangle(
								_buttonWidth,
								Color(0xffF9FDFE),
								text: 'Set Up',
								textColor: Color(0xff6DD7AF)
							),
						]
					)
				)
			],
		);
	}
}
