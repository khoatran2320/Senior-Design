import "package:flutter/material.dart";
import "../../../utils/colors.dart";
import "../../../pages/signin_page.dart";

class WelcomePageButtonGetStarted extends StatelessWidget{
  final String _text;
  final Function _viewHeight;
  final Function _viewWidth;

  const WelcomePageButtonGetStarted(this._text, this._viewWidth, this._viewHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.only(top: 0),
            width: _viewWidth(0.65),
            height: _viewHeight(.07),
            child: TextButton(onPressed: (){
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            }, 
              child: Text(_text,
                style: TextStyle(
                  color:Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorPallete.cOSecondary),
              )
            ),
          );
  }
}