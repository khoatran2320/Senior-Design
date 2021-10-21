import "package:flutter/material.dart";

const Color cPrimary = Color(0xff0892A5); // rgb(8, 146, 165)
const Color cSecondary = Color(0xff06908F);
const Color cThirdColor = Color(0xff0CA4A5);
const Color cFourthColor = Color(0xffDBB68F);
const Color cFifthColor = Color(0xffBB7E5D);

const Color cOPrimary = Color(0xff446491);
const Color cOSecondary = Color(0xff4B89AC);
const Color cOThirdColor = Color(0xffE4FCF9);
const Color cOFourthColor = Color(0xff6DD7AF);
const Color cOFifthColor = Color(0xffE4FCF9);

Map<int, Color> materialColorGenerator(int r, int g, int b){
  return {
    50:Color.fromRGBO(r, g, b, 0.1),
    100:Color.fromRGBO(r, g, b, 0.2),
    200:Color.fromRGBO(r, g, b, 0.3),
    300:Color.fromRGBO(r, g, b, 0.4),
    400:Color.fromRGBO(r, g, b, 0.5),
    500:Color.fromRGBO(r, g, b, 0.6),
    600:Color.fromRGBO(r, g, b, 0.7),
    700:Color.fromRGBO(r, g, b, 0.8),
    800:Color.fromRGBO(r, g, b, 0.9),
    900:Color.fromRGBO(r, g, b, 1),
    };
}
