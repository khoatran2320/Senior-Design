import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import "../pages/dashboard.dart";
import '../../utils/authentication_service.dart';

class SettingsPage extends StatelessWidget {

	final TextStyle textStyle = const TextStyle(
		color: Colors.black,
		decoration: TextDecoration.none,
		fontSize: 30
	);

	void signOutHandler(context) {
		print('Signout');
		FirebaseAuth.instance.signOut();
		Navigator.of(context)
				.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
	}

	void goBackToDashboard(context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
	}


	Widget build(BuildContext context) {
		return Container(
			color: Colors.white,
			padding: EdgeInsets.all(50),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					GestureDetector(
						onTap: () {
							goBackToDashboard(context);
						},
						child: Text(
							'Back',
							style: TextStyle(
								color: Colors.blue,
								decoration: TextDecoration.none,
								fontSize: 20
							)
						)
					),
					GestureDetector(
						onTap: () {
							signOutHandler(context);
						},
						child: Text(
							'Log Out',
							style: textStyle
						)
					)
				]
			)
		);
	}
}
