import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeletePackageForm extends StatefulWidget {
	final String trackingNumber;
	final Function refreshPackageList;

	const DeletePackageForm(
		this.trackingNumber, this.refreshPackageList, { Key? key }
	) : super(key: key);

	@override
	DeletePackageFormState createState() {
		return DeletePackageFormState();
	}
}

class DeletePackageFormState extends State<DeletePackageForm> {
	// TODO: Check if I still need formKey
	final _formKey = GlobalKey<FormState>();
	bool showApiError = false;

	String?	errorMsg = "";

	void showErrorBox () {
		setState(() {
			showApiError = true;
		});
	}

	void deletePackage(String trackingNumber, Function refreshPackageList) async {
		bool success = false;

		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = 'http://localhost:3000/package?userId=${userId}&trackingNumber=${trackingNumber}';

		var response = await http.delete(
			Uri.parse(uri)
	  );

		if (response.statusCode == 200) {
			success = true;
			refreshPackageList();
			Navigator.pop(context);
		} else {
			errorMsg = jsonDecode(response.body)["msg"];
			showErrorBox();
		}
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
							deletePackage(widget.trackingNumber, widget.refreshPackageList);
						},
						child: const Text('Yes'),
					)
				]
			)
		);

		Widget errorBox = Column(
			children: [
				Text(
					'Error'
				),
				Text(
					errorMsg.toString()
				),
				ElevatedButton(
					onPressed: () {
						Navigator.pop(context);
					},
					child: const Text('OK'),
				)
			]
		);

		return showApiError ? errorBox : form;
	}
}
