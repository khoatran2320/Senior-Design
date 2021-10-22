import "package:flutter/material.dart";

class SignInPageFieldPass extends StatefulWidget{
  Function callback;

  SignInPageFieldPass(this.callback);

  @override
  State<StatefulWidget> createState()=>_SignInPageFieldPass();
}

class _SignInPageFieldPass extends State<SignInPageFieldPass>{
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
            onChanged: (value) {
              widget.callback(value);
            },
          );
  }
}