import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeletePackageForm extends StatefulWidget {
	final String trackingNumber;

	const DeletePackageForm(this.trackingNumber, { Key? key }) : super(key: key);

	@override
	DeletePackageFormState createState() {
		return DeletePackageFormState();
	}
}

class DeletePackageFormState extends State<DeletePackageForm> {
	// TODO: Check if I still need formKey
	final _formKey = GlobalKey<FormState>();
	bool showResult = false;

	String?	apiResult = "";
	String? apiResultType = "";

	void showAPIResult () {
		setState(() {
			showResult = true;
		});
	}

	void deletePackage(String trackingNumber) async {
		bool success = false;

		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = 'http://localhost:3000/package?userId=${userId}&trackingNumber=${trackingNumber}';

		var response = await http.delete(
			Uri.parse(uri)
	  );

		if (response.statusCode == 200) {
			success = true;
		}

		apiResultType = success ? '' : 'Error';
		apiResult = jsonDecode(response.body)["msg"];
		showAPIResult();
	}

	@override
	Widget build(BuildContext context) {

		Widget form = Form(
			key: _formKey,
			child: Column(
				children: <Widget>[
					Padding(
						padding: EdgeInsets.all(15),
						child: Text(
							"Stop tracking this delivery item?"
						)
					),
					ElevatedButton(
						onPressed: () {
							deletePackage(widget.trackingNumber);
						},
						child: const Text('Yes'),
					)
				]
			)
		);

		// TODO: If it's a success, skip apiResultBox and refresh list instead
		Widget apiResultBox = Column(
			children: [
				Text(
					apiResultType.toString()
				),
				Text(
					apiResult.toString()
				),
				ElevatedButton(
					onPressed: () {
						Navigator.pop(context);
					},
					child: const Text('OK'),
				)
			]
		);

		return showResult ? apiResultBox : form;
	}
}
