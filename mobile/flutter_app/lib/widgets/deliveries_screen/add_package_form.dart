// Referenced https://docs.flutter.dev/cookbook/forms/validation
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/models/package_list_model.dart';

class AddPackageForm extends StatefulWidget {
	const AddPackageForm({ Key? key }) : super(key: key);

	@override
	AddPackageFormState createState() {
		return AddPackageFormState();
	}
}

final _formKey = GlobalKey<FormState>();

class AddPackageFormState extends State<AddPackageForm> {
	bool showError = false;
	String? itemName = "";
	String? trackingNumber = "";
	String? merchantName = "";
	String? orderNumber = "";

	String?	errorMessage = "";

	void showErrorMessage ([bool show = true]) {
		if (show) {
			setState(() {
				showError = true;
			});
		} else {
			setState(() {
				showError = false;
			});
		}
	}

	void addPackage() async {
		var apiResult = await Provider.of<PackageListModel>(context, listen: false).add(
			itemName,
			trackingNumber,
			merchantName,
			orderNumber
		);

		bool success = apiResult['success'];

		if (success) {
			Navigator.pop(context);
		}
		else {
			errorMessage = apiResult['errorMsg'];
			showErrorMessage();
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
						child: Column(
							children: <Widget>[
								TextFormField(
									decoration: const InputDecoration(
			              labelText: 'Item Name'
			            ),
									onSaved: (value) {
			              itemName = value;
			          	},
									validator: (value) {
										if (value == null || value.isEmpty) {
											return 'Please enter the item name.';
										}

										return null;
									}
								),
								TextFormField(
									decoration: const InputDecoration(
			              labelText: 'Tracking Number'
			            ),
									onSaved: (value) {
			              trackingNumber = value;
			          	},
									validator: (value) {
										if (value == null || value.isEmpty) {
											return 'Please enter a tracking number.';
										}

										return null;
									}
								),
								TextFormField(
									decoration: const InputDecoration(
			              labelText: 'Merchant Name (optional)'
			            ),
									onSaved: (value) {
										if (value == null || value.isEmpty) {
											value = "";
										}

			              merchantName = value;
			          	}
								),
								TextFormField(
									decoration: const InputDecoration(
			              labelText: 'Order # (required for Amazon tracking)'
			            ),
									onSaved: (value) {
										if (value == null || value.isEmpty) {
											value = "";
										}

			              orderNumber = value;
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
								addPackage();
							}
						},
						child: const Text('Add'),
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
					errorMessage.toString()
				),
				ElevatedButton(
					onPressed: () {
						errorMessage = "";
						showErrorMessage(false);
						Navigator.pop(context);
					},
					child: const Text('OK'),
				)
			]
		);

		return showError ? errorBox : form;
	}
}
