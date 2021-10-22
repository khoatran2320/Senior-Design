import 'package:flutter/material.dart';
import '../../../pages/signup_page.dart';
import '../../../utils/colors.dart';

class RedirectSignUp extends StatelessWidget {
  final double _width;
  final double _height;

  const RedirectSignUp(this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        Container(
          padding: const EdgeInsets.all(0),
          margin: EdgeInsets.only(left: _width),
          width: _width,
          height: _height,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: const Text(
              "Sign up",
              style: TextStyle(
                color: ColorPallete.cSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
