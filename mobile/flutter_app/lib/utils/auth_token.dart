import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> setupToken() async {
  print("setupToken");
  // Get the token each time the application loads
  String? token = await FirebaseMessaging.instance.getToken();

  // Save the initial token to the database
  await saveTokenToDatabase(token!);

  // Any time the token refreshes, store this in the database too.
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
}


// This token is used for sending push notifications
Future<void> saveTokenToDatabase(String token) async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  print("Adding token");

  FirebaseFirestore.instance
    .collection('user_tokens')
    .doc(userId)
    .get()
    .then((_) {
      FirebaseFirestore.instance
        .collection('user_tokens')
        .doc(userId)
        .update({
        'tokens': FieldValue.arrayUnion([token])
        })
        .then((_) {
          print("Token generated for user");
        })
        .catchError((error) {
          print("Failed to generate token for user: $error");
        });
    })
    .catchError((err) {
      FirebaseFirestore.instance
        .collection('user_tokens')
        .doc(userId)
        .set(
          { 'tokens': [ token ] }
        )
        .then((_) {
          print("Token generated for user");
        })
        .catchError((error) {
          print("Failed to generate token for user: $error");
        });
    });
}
