
import "package:flutter/material.dart";
import "./colors.dart";

class MainPage extends StatelessWidget{
  const MainPage({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){

    double _viewWidth(double percent){
      return MediaQuery.of(context).size.width*percent;
    }
    double _viewHeight(double percent){
      return MediaQuery.of(context).size.height*percent;
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: _viewWidth(0.40),
            margin: const EdgeInsets.all( 0),
            padding: const EdgeInsets.all(0),
            child: Image.asset("assets/images/corner_circles.png", 
              width: double.infinity,
              alignment: Alignment.topLeft,
           )
          ),
          Container(
            margin: EdgeInsets.only(bottom: _viewHeight(0.03)),
            child: const Text("BOXi", 
              style: TextStyle(
                color: cPrimary, 
                fontSize: 48, 
                fontWeight: FontWeight.bold, 
              ),
          ), 
          ),
          Image.asset("assets/images/delivery_pic.png", ), 
          const Text("Safe delivery across homes",
            style: TextStyle(
                color: cSecondary, 
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
          ), 
          Container(
            margin: EdgeInsets.only(bottom: _viewHeight(0.03)),
            child: const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id risus lobortis leo varius sed enim quis nisl. Habitant tincidunt egestas est sed dapibus.",
              style: TextStyle(
                color: cThirdColor, 
                fontSize: 16, 
              ),
            ), 
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            width: _viewWidth(0.65),
            height: _viewHeight(.07),
            child: TextButton(onPressed: null, 
              child: const Text("Get Started",
                style: TextStyle(
                  color: Color(0xffE4FCF9),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(cSecondary),
              )
            ),
          )
        ],
      ),
      );
  }
}