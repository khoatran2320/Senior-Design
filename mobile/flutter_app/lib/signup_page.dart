// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


import 'package:flutter/material.dart';
import './colors.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmPass = TextEditingController();
  String _email = "";
  String _name = "";
  @override
  Widget build(BuildContext context) {
    double _viewWidth(double percent){
      return MediaQuery.of(context).size.width*percent;
    }
    double _viewHeight(double percent){
      return MediaQuery.of(context).size.height*percent;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        backgroundColor: cPrimary,
      ),
      body: Form(
        key: _form,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
            child: Column(
              children: [
                ...[
                  Image.asset("assets/images/delivery_pic.png", ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Your name',
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (val){
                      if(val == null){
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Your email address',
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      _email = value;
                    },
                    validator: (val){
                      if(val!.isEmpty){
                        return "Please enter your email";
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    controller: _pass,
                    validator: (val){
                      if(val!.isEmpty){
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
                    validator: (val){
                      if(val!.isEmpty){
                        return 'Please re-enter password';
                      }
                      if(_pass.text != _confirmPass.text){
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    width: _viewWidth(0.4),
                    height: _viewHeight(.05),
                    child: TextButton(onPressed: (){_form.currentState!.validate();}, 
                      child: const Text("Sign up",
                        style: TextStyle(
                          color:Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(cSecondary),
                      )
                    ),
                  ),
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