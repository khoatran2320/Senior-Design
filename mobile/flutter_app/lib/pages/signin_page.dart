// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import './signup_page.dart';
import 'package:provider/provider.dart';
import '../utils/authentication_service.dart';
import "../widgets/forms/sign_in/email_field.dart";
import "../widgets/forms/sign_in/password_field.dart";
import "../widgets/forms/sign_in/redirect_signup.dart";


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
    double _viewWidth(double percent) {
      return MediaQuery.of(context).size.width * percent;
    }

    double _viewHeight(double percent) {
      return MediaQuery.of(context).size.height * percent;
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
                  Image.asset(
                    "assets/images/delivery_pic.png",
                  ),
                  SignInPageFieldEmail(emailCallback),
                  SignInPageFieldPass(passwordCallback),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    width: _viewWidth(0.4),
                    height: _viewHeight(.05),
                    child: TextButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            context.read<AuthenticationService>().signIn(
                                  email: email,
                                  password: password,
                                );
                          }
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorPallete.cSecondary),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      Container(
                        padding: const EdgeInsets.all(0),
                        margin: EdgeInsets.only(left: _viewWidth(0.02)),
                        width: _viewWidth(0.2),
                        height: _viewHeight(.06),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ColorPallete.cSecondary),
                            )),
                      ),
                    ],
                  )
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

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
