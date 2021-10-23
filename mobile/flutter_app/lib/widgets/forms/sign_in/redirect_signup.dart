import 'package:flutter/material.dart';
import '../../../pages/signup_page.dart';
import '../../../utils/colors.dart';

class RedirectSignUp extends StatelessWidget {
  final Function _viewWidth;
  final Function _viewHeight;

  const RedirectSignUp(this._viewWidth, this._viewHeight);

  @override
  Widget build(BuildContext context) {
   return  Row(
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
          );
  }
}
