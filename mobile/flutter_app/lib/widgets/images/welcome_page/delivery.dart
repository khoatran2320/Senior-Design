import "package:flutter/material.dart";

class WelcomePageImageDelivery extends StatelessWidget{
  final Function _viewWidth;

  const WelcomePageImageDelivery(this._viewWidth);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _viewWidth(0.40),
            margin: const EdgeInsets.all( 0),
            padding: const EdgeInsets.all(0),
            child: Image.asset("assets/images/corner_circles.png", 
              width: double.infinity,
              alignment: Alignment.topLeft,
           )
    );
  }
}