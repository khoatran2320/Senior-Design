import 'package:flutter/material.dart';
import "splash.dart";
import "./colors.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff0892A5, materialColorGenerator(8, 146, 165)),
      ),
      home: const Splash(),
    );
  }
} 
