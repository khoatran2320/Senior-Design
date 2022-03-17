import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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

	void unlock() async {

		// TODO: Update hardcoded uri and boxiId to dynamically fetched versions
		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = "http://localhost:3000/mobile/unlock-box";
		String boxiId = "boxi_prototype_00000";

		Map data = {
			'userId': userId,
			'boxiId': boxiId
		};

		var body = json.encode(data);

		var response = await http.post(
			Uri.parse(uri),
      headers: {
				'Content-Type': 'application/json;charset=UTF-8',
				'Charset': 'utf-8'
			},
      body: body
	  );

		if (response.statusCode == 200) {
			setState(() {
				isLocked = false;
			});
		}
		else {
			print('Error unlocking button');
		}
		// TODO: Add popup for "Unlocking BOXi failed"
		// figure out how to show popup, refer to code from add package form
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
