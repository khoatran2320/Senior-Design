import 'package:flutter/material.dart';
import '../../../signup_page.dart';
import '../../../colors.dart';

class RedirectSignUp extends StatelessWidget {
  final Function viewWidth;
  final Function viewHeight;

  const RedirectSignUp(this.viewWidth, this.viewHeight);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        Container(
          padding: const EdgeInsets.all(0),
          margin: EdgeInsets.only(left: viewWidth(0.02)),
          width: viewWidth(0.2),
          height: viewHeight(.04),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: const Text(
              "Sign up",
              style: TextStyle(
                color: cSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
