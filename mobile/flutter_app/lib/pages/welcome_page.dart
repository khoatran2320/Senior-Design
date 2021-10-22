
import "package:flutter/material.dart";

import '../widgets/images/welcome_page/delivery.dart';
import "../widgets/texts/welcome_page/subheader.dart";
import "../widgets/texts/welcome_page/header.dart";
import "../widgets/texts/welcome_page/description.dart";
import "../widgets/buttons/welcome_page/get_started.dart";

class MainPage extends StatelessWidget{
  const MainPage({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    double _viewWidth(double percent) {
      return MediaQuery.of(context).size.width * percent;
    }

    double _viewHeight(double percent) {
      return MediaQuery.of(context).size.height * percent;
    }
    return Scaffold(
      body: Column(
        children: [
          WelcomePageImageDelivery(_viewWidth),
          WelcomePageHeader("BOXi", _viewHeight),
          Image.asset("assets/images/delivery_pic.png", ), 
          WelcomePageSubHeader("Safe delivery across homes"), 
          WelcomePageDescription("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id risus lobortis leo varius sed enim quis nisl. Habitant tincidunt egestas est sed dapibus.", _viewHeight),
          WelcomePageButtonGetStarted("Get Started", _viewWidth, _viewHeight)
        ],
      ),
    );
  }
}