import "package:flutter/material.dart";

class SignInPageFieldEmail extends StatefulWidget{
  final Function callback;

  const SignInPageFieldEmail(this.callback);

  @override
  State<StatefulWidget> createState()=>_SignInPageFieldEmailState();
}

class _SignInPageFieldEmailState extends State<SignInPageFieldEmail>{
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Your email address',
              labelText: 'Email',
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(val)) {
                return 'Please a valid Email';
              }
              return null;
            },
            onChanged: (value) {
              widget.callback(value);
            },
          );
  }
}