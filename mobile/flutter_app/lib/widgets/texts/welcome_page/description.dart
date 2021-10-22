import "package:flutter/material.dart";
import "../../../utils/colors.dart";

class WelcomePageDescription extends StatelessWidget{
  final String _text;
  final Function _viewHeight;

  const WelcomePageDescription(this._text, this._viewHeight);


  @override
  Widget build(BuildContext context) {

    return Container(
            margin: EdgeInsets.only(bottom: _viewHeight(0.03)),
            child: Text(_text,
              style: TextStyle(
                color: ColorPallete.cThirdColor, 
                fontSize: 16, 
              ),
            ), 
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            width: double.infinity,
          );
  }
}