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

final _formKey = GlobalKey<FormState>();

class SetupDialogState extends State<SetupDialog> {
	String box = "confirmSetupDialog"; // Other options: wifiForm, qrCodeBox
	bool showQRCode = false;
	String qrData = "";

	bool showError = false;
	String? wifiUsername = "";
	String? wifiPassword = "";

	String?	errorMessage = "";

	generateQRCode() {
		String data = "###\$$wifiUsername\$$wifiPassword\$###";

		setState(() {
			showQRCode = true;
			qrData = data;
		});
	}

	changeBox(boxName) {
		setState(() {
			box = boxName;
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
				  data: qrData,
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
									changeBox("wifiForm");
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

		Widget wifiForm = Form(
			key: _formKey,
			child: Column(
				children: <Widget>[
					Padding(
						padding: EdgeInsets.all(15),
						child: Column(
							children: <Widget>[
								TextFormField(
									decoration: const InputDecoration(
			              labelText: 'WiFi Username'
			            ),
									onSaved: (value) {
			              wifiUsername = value;
			          	},
									validator: (value) {
										if (value == null || value.isEmpty) {
											return 'Please enter the WiFi username.';
										}

										return null;
									}
								),
								TextFormField(
									decoration: const InputDecoration(
			              labelText: 'WiFi Password'
			            ),
									onSaved: (value) {
			              wifiPassword = value;
			          	},
									validator: (value) {
										if (value == null || value.isEmpty) {
											return 'Please enter the WiFi password.';
										}

										return null;
									}
								)
							]
						)
					),
					ElevatedButton(
						onPressed: () {
						// Validate returns true if the form is valid, or false otherwise.
							if (_formKey.currentState!.validate()) {
								_formKey.currentState?.save();
								generateQRCode();
								changeBox("qrCodeBox");
							}
						},
						child: const Text('Set Up WiFi'),
					)
				]
			)
		);

		if (box == "qrCodeBox") {
			return qrCodeBox;
		} else if (box == "wifiForm") {
			return wifiForm;
		} else {
			return confirmSetupDialog;
		}

		return showQRCode ? qrCodeBox : confirmSetupDialog;
	}
}
