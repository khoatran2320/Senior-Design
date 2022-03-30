import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/models/package_list_model.dart';

class DeletePackageForm extends StatefulWidget {
	final String trackingNumber;

	const DeletePackageForm(
		this.trackingNumber, { Key? key }
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

	void showErrorBox ([bool show = true]) {
		if (show) {
			setState(() {
				showApiError = true;
			});
		} else {
			setState(() {
				showApiError = false;
			});
		}
	}

	void deletePackage(String trackingNumber) async {

		var apiErrorMsg = await Provider.of<PackageListModel>(context, listen: false).delete(trackingNumber);

		if (apiErrorMsg.isEmpty) {
			Navigator.pop(context);
		}
		else {
			errorMsg = apiErrorMsg;
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
							deletePackage(widget.trackingNumber);
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
						errorMsg = "";
						showErrorBox(false);
						Navigator.pop(context);
					},
					child: const Text('OK'),
				)
			]
		);

		return showApiError ? errorBox : form;
	}
}
