import "package:flutter/material.dart";
import "../../../utils/colors.dart";

class SignUpPageButtonSubmit extends StatelessWidget{
  final Function _viewWidth;
  final Function _viewHeight;
  final Function _handler;

  const SignUpPageButtonSubmit(this._handler, this._viewWidth, this._viewHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.only(top: 0),
            width: _viewWidth(0.4),
            height: _viewHeight(.05),
            child: TextButton(
                onPressed: () => _handler(),
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
          );
  }
}