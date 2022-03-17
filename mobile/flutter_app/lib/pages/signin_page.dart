// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/deliveries_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/colors.dart';
import '../utils/authentication_service.dart';
import "../widgets/forms/sign_in/email_field.dart";
import "../widgets/forms/sign_in/password_field.dart";
import "../widgets/forms/sign_in/redirect_signup.dart";
import "../widgets/buttons/signin_page/submit.dart";
import "../pages/dashboard.dart";
import '/utils/authentication_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  String email = "";
  String password = "";
  String _errorMsg = "";
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final firebaseUser = ref.read(firebaseAuthProvider).userChanges();
  }

  void emailCallback(String text) {
    email = text;
  }

  void passwordCallback(String text) {
    password = text;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = ref.watch(firebaseAuthProvider).userChanges();

    if (firebaseUser != null) {
      print('Found User Logged In');
    } else {
      print('User not logged in');
    }

    double _viewWidth(double percent) {
      return MediaQuery.of(context).size.width * percent;
    }

    double _viewHeight(double percent) {
      return MediaQuery.of(context).size.height * percent;
    }

    void submitHandler() {
      _errorMsg = "";
      final _auth = ref.read(firebaseAuthProvider);

      if (_form.currentState!.validate()) {
        try {
          _auth.signInWithEmailAndPassword(email: email, password: password);
        } catch (e) {
          _errorMsg = "Invalid email and password combination.";
        }
      }

      final _authState = ref.watch(authStateProvider);

      // Go to Dashboard when user is logged in
      return _authState.when(
        // User data is available == logged in
        data: (data) {
          if (data != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          }
        }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        backgroundColor: ColorPallete.cPrimary,
      ),
      body: Form(
        key: _form,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
            child: Column(
              children: [
                ...[
                  Image.asset("assets/images/delivery_pic.png"),
                  SignInPageFieldEmail(emailCallback),
                  SignInPageFieldPass(passwordCallback, _errorMsg),
                  SignInPageButtonSubmit(
                      submitHandler, _viewWidth, _viewHeight),
                  RedirectSignUp(_viewWidth, _viewHeight),
                ].expand((widget) => [widget, const SizedBox(height: 24)])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   void _showDialog(String message) {
//     showDialog<void>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(message),
//         actions: [
//           TextButton(
//             child: const Text('OK'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
// }
