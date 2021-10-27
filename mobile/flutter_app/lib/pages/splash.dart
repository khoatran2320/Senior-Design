import "dart:async";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "welcome_page.dart";
import "signin_page.dart";
import 'package:after_layout/after_layout.dart';


class Splash extends StatefulWidget{
  const Splash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash>{
  Future checkFirstSeen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool("seenWelcomeScreen") ?? false);

    if(_seen){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn())
      );
    }
    else{
      await prefs.setBool("seenWelcomeScreen", true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage())
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
