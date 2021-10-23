import "package:flutter/material.dart";

class SignUpPageFieldName extends StatelessWidget{
  final Function _callback;

  const SignUpPageFieldName(this._callback);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Your name',
              labelText: 'Name',
            ),
            onChanged: (value) {
              _callback(value);
            },
            validator: (val) {
              if (val == null) {
                return "Please enter your name";
              }
              return null;
            },
          );
  }
}