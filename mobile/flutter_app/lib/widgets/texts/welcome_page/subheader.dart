import "package:flutter/material.dart";
import "../../../utils/colors.dart";

class WelcomePageSubHeader extends StatelessWidget{
  final String _text;

  const WelcomePageSubHeader(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(_text,
            style: TextStyle(
                color: ColorPallete.cOSecondary, 
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
          );
  }
}