// Reference: https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple

import 'dart:collection';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/models/package.dart';


class PackageListModel extends ChangeNotifier {
	final List<Package> _packageList = [];

	// initialize package list by pulling from backend

	// packageList is not modifiable but updates when _packageList updates
	UnmodifiableListView<Package> get packageList => UnmodifiableListView(_packageList);

	PackageListModel() {
		this.loadList();
	}

	// TODO: catch exception
	Future<void> loadList() async {
		_packageList.clear();

    String? userId = FirebaseAuth.instance.currentUser?.uid;
    final response = await http.get(Uri.parse(
        'http://localhost:3000/package/all?userId=$userId'));

    if (response.statusCode == 200) {
      var responsePackages = jsonDecode(response.body)["data"];
			// TODO: Fill in proper fields for Package
      responsePackages.forEach((trackingNum, v) =>
        _packageList.add(
					Package(
            trackingNum,
            trackingNum,
            v['status_description'],
            trackingNum
        	)
				)
			);

			notifyListeners();

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load packages');
    }
	}

	Future<Map> add(
		String? itemName,
		String? trackingNumber,
		String? merchantName,
		String? orderNumber
	) async {

		bool success = false;
		String errorMsg = "";

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
			await this.loadList();
			notifyListeners();
		} else {
			errorMsg = jsonDecode(response.body)["msg"];
		}

		return {
			"success": success,
			"errorMsg": errorMsg
		};
	}

	// TODO: Call api and then call this fnc
	Future<String> delete(String trackingNum) async {

		bool success = false;

		String? userId = FirebaseAuth.instance.currentUser?.uid;
		String uri = 'http://localhost:3000/package?userId=${userId}&trackingNumber=${trackingNum}';

		var response = await http.delete(
			Uri.parse(uri)
	  );

		if (response.statusCode == 200) {
			success = true;
			await this.loadList();
			notifyListeners();
		}

		String apiResult = jsonDecode(response.body)["msg"];

		return success ? "" : apiResult;
	}
}
