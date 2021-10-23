// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/authentication_service.dart';

import '../utils/colors.dart';

import "../widgets/forms/sign_up/name_field.dart";
import "../widgets/forms/sign_in/email_field.dart";
import "../widgets/buttons/signup_page/submit.dart";

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmPass = TextEditingController();
  String _email = "";
  String _name = "";

  void nameCallback(String text){
    _name = text;
  }

  void emailCallback(String text){
    _email = text;
  }

  void _submitHandler(){
    if (_form.currentState!.validate()) {
        context.read<AuthenticationService>().signUp(
              email: _email,
              password: _pass.text.trim(),
            );
      }
  }

  @override
  Widget build(BuildContext context) {
    double _viewWidth(double percent) {
      return MediaQuery.of(context).size.width * percent;
    }

    double _viewHeight(double percent) {
      return MediaQuery.of(context).size.height * percent;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
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
                  SignUpPageFieldName(nameCallback),
                  SignInPageFieldEmail(emailCallback),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    controller: _pass,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Confirm password',
                    ),
                    obscureText: true,
                    controller: _confirmPass,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please re-enter password';
                      }
                      if (_pass.text != _confirmPass.text) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                  ),
                  SignUpPageButtonSubmit(_submitHandler, _viewWidth, _viewHeight)
                ].expand(
                  (widget) => [
                    widget,
                    const SizedBox(
                      height: 24,
                    )
                  ],
                )
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
