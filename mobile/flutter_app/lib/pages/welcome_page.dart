
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
          WelcomePageDescription("Shopping online should be easy and hassle-free! Gone are the days where you have to deal with customer support for hours because of lost packages! Ready for a peace of mind? Start using BOXi!", _viewHeight),
          WelcomePageButtonGetStarted("Get Started", _viewWidth, _viewHeight)
        ],
      ),
    );
  }
}