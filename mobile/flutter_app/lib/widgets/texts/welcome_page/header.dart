import "package:flutter/material.dart";
import "../../../utils/colors.dart";

class WelcomePageHeader extends StatelessWidget{
  final String _text;
  final Function _viewHeight;

  const WelcomePageHeader(this._text, this._viewHeight);

  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: EdgeInsets.only(bottom: _viewHeight(0.03)),
            child: Text(_text, 
              style: TextStyle(
                color: ColorPallete.cPrimary, 
                fontSize: 48, 
                fontWeight: FontWeight.bold, 
              ),
          ), 
        );
  }
}