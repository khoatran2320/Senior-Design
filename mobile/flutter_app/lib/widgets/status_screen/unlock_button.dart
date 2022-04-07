import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/models/lock_model.dart';
import '/utils/colors.dart';

final serverUrl = dotenv.env['SERVER_URL'];

// TODO: Pass isLocked parameter.
class UnlockButton extends StatefulWidget {
	const UnlockButton({ Key? key }) : super(key: key);

	@override
	_UnlockButtonState createState() => _UnlockButtonState();
}

class _UnlockButtonState extends State<UnlockButton> {

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 18,
		fontWeight: FontWeight.w500
	);

	void initState() {
		super.initState();
	}

	void unlock(context) async {

		// TODO: Update hardcoded uri and boxiId to dynamically fetched versions
		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = "${serverUrl}/mobile/unlock-box";
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
			// Update isLocked to false
			Provider.of<LockModel>(context, listen: false).update(false);
		}
		else {
			print('Error');
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
								unlock(context);
							},
							child: Consumer<LockModel>(
		            builder: (context, lockModel, child) {
		              return Icon(
										lockModel.isLocked ? Icons.lock : Icons.lock_open,
										color: Color(0xffE4FCF9),
										size: 60
									);
		            }
		          )
						),
					],
				),
				Consumer<LockModel>(
					builder: (context, lockModel, child) {
						var isLocked = lockModel.isLocked;

						return TextButton(
							child: Text(
								isLocked
									? 'Tap to Unlock'
									: 'Close the box lid to lock it.',
								style: textStyle
							),
							onPressed: () {
								isLocked ? unlock(context) : null;
							}
						);
					}
				)
			]
		);
	}
}
