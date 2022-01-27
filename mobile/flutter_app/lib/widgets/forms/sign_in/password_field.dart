import "package:flutter/material.dart";

class SignInPageFieldPass extends StatefulWidget {
  Function callback;
  String? errorMsg;

  SignInPageFieldPass(this.callback, this.errorMsg);

  @override
  State<StatefulWidget> createState() => _SignInPageFieldPass();
}

class _SignInPageFieldPass extends State<SignInPageFieldPass> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        filled: true,
        labelText: 'Password',
        errorText: "Invalid email and password combination.",
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
