// Referenced https://docs.flutter.dev/cookbook/forms/validation
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddPackageForm extends StatefulWidget {
	const AddPackageForm({ Key? key }) : super(key: key);

	@override
	AddPackageFormState createState() {
		return AddPackageFormState();
	}
}


class AddPackageFormState extends State<AddPackageForm> {
	final _formKey = GlobalKey<FormState>();
	bool showResult = false;
	String? itemName = "";
	String? trackingNumber = "";
	String? merchantName = "";

	String?	apiResult = "";
	String? apiResultType = "";

	void showAPIResult () {
		setState(() {
			showResult = true;
		});
	}

	void addPackage() async {
		bool success = false;

		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = 'http://localhost:3000/package?userId=${userId}&trackingNumber=${trackingNumber}';
		print('uri $uri');

		final response = await http.post(
			Uri.parse(uri)
		);

		if (response.statusCode == 200) {
			success = true;
		}

		apiResultType = success ? 'Success' : 'Error';
		apiResult = jsonDecode(response.body)["payload"];
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
			              merchantName = value;
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
