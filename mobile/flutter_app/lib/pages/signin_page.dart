// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/deliveries_screen.dart';
import '../utils/colors.dart';
import 'package:provider/provider.dart';
import '../utils/authentication_service.dart';
import "../widgets/forms/sign_in/email_field.dart";
import "../widgets/forms/sign_in/password_field.dart";
import "../widgets/forms/sign_in/redirect_signup.dart";
import "../widgets/buttons/signin_page/submit.dart";
import "../pages/dashboard.dart";

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void emailCallback(String text){
    email = text;
  }
  void passwordCallback(String text){
    password = text;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

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

    void submitHandler(){
      if(_form.currentState!.validate()){
        context.read<AuthenticationService>().signIn(email: email, password: password);
      }
      if(context.read<AuthenticationService>().isLoggedIn()){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
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
                  SignInPageFieldPass(passwordCallback),
                  SignInPageButtonSubmit(submitHandler, _viewWidth, _viewHeight),
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
