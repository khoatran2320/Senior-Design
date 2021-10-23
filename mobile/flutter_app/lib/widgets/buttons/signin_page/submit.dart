import "package:flutter/material.dart";
import "../../../utils/colors.dart";

class SignInPageButtonSubmit extends StatelessWidget{
  final Function _handler;
  final Function _viewHeight;
  final Function _viewWidth;

  const SignInPageButtonSubmit(this._handler, this._viewWidth, this._viewHeight);
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.only(top: 0),
            width: _viewWidth(0.4),
            height: _viewHeight(.05),
            child: TextButton(
                onPressed: ()=>_handler(),
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
          );
  }
}