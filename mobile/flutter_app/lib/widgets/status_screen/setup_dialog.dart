import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class SetupDialog extends StatefulWidget {
	const SetupDialog({ Key? key }) : super(key: key);

	@override
	SetupDialogState createState() {
		return SetupDialogState();
	}
}

class SetupDialogState extends State<SetupDialog> {
	// TODO: Check if I still need formKey
	final _formKey = GlobalKey<FormState>();
	bool showQRCode = false;
	String userId = "";

	generateQRCode() {
		// TODO: Call server for userID
		String generatedUserId = "Where user_id should go";

		setState(() {
			showQRCode = true;
			userId = generatedUserId;
		});
	}

	@override
	Widget build(BuildContext context) {

		Widget qrCodeBox = Column(
			children: [
				Text(
					"Please scan this QR code with BOXi:"
				),
				QrImage(
				  data: userId,
				  version: QrVersions.auto,
				  size: 320,
				  gapless: false,
				),
				ElevatedButton(
					onPressed: () {
						Navigator.pop(context);
					},
					child: const Text('Done'),
				)
			]
		);

		Widget confirmSetupDialog = Form(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceAround,
				children: <Widget>[
					Padding(
						padding: EdgeInsets.all(15),
						child: Text(
							"Let's set up BOXi!"
						)
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children: [
							ElevatedButton(
								onPressed: () {
									generateQRCode();
								},
								child: const Text('OK'),
							),
							ElevatedButton(
								onPressed: () {
									Navigator.pop(context);
								},
								child: const Text('Already done.'),
							)
						]
					)
				]
			)
		);

		return showQRCode ? qrCodeBox : confirmSetupDialog;
	}
}
