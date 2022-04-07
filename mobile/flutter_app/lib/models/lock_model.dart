import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

final serverUrl = dotenv.env['SERVER_URL'];

class LockModel extends ChangeNotifier {
	bool isLocked = true;

	LockModel() {
		getLockStatus();
	}

	// TODO: Fetch actual boxiId
	// Just gonna assume each user has one boxi here
	Future<void> getLockStatus() async {
		// get user id
		// get boxi id
		// get boxi unlock_status

		// Hardcode boxi id for now

		// Assume jon wick user account
    String? userId = FirebaseAuth.instance.currentUser?.uid;
		String boxiId = "boxi_prototype_00000";

    final response = await http.get(Uri.parse(
        '$serverUrl/boxi/unlock-status?userId=$userId&boxiId=$boxiId'));

    if (response.statusCode == 200) {
      bool unlock_status = jsonDecode(response.body)["data"];
			isLocked = !unlock_status;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get unlock_status');
    }
	}

	void update(bool isLockedParam) async {
		print("isLocked is updated");
		isLocked = isLockedParam;
		notifyListeners();
	}
}
