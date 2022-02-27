// Referenced https://docs.flutter.dev/cookbook/forms/validation
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPackageForm extends StatefulWidget {
	final Function refreshPackageList;
	const AddPackageForm(this.refreshPackageList, { Key? key }) : super(key: key);

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
	String? orderNumber = "";

	String?	apiResult = "";
	String? apiResultType = "";

	void showAPIResult () {
		setState(() {
			showResult = true;
		});
	}

	void addPackage(Function refreshPackageList) async {
		bool success = false;

		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = 'http://localhost:3000/package';

		Map data = {
			'userId': userId,
			'trackingNumber': trackingNumber
		};

		var body = json.encode(data);

		var response = await http.post(
			Uri.parse(uri),
      headers: {"Content-Type": "application/json"},
      body: body
	  );

		if (response.statusCode == 200) {
			success = true;
			refreshPackageList();
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
								addPackage(widget.refreshPackageList);
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
