import "package:flutter/material.dart";

class MainPage extends StatelessWidget{
  const MainPage({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/corner_circles.png", 
            width: double.infinity,
            alignment: Alignment.topLeft,
          ), 
          const Text("BOXi", 
            style: TextStyle(
              color: Color.fromARGB(255, 68, 100, 145), 
              fontSize: 48, 
              fontWeight: FontWeight.bold, 
            ),
          ), 
          Image.asset("assets/images/delivery_pic.png", ), 
          const Text("Safe delivery across homes",
            style: TextStyle(
                color: Color.fromARGB(255, 68, 100, 145), 
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
          ), 
          Container(
            child: const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id risus lobortis leo varius sed enim quis nisl. Habitant tincidunt egestas est sed dapibus.",
              style: TextStyle(
                color: Color.fromARGB(255, 75, 137, 172), 
                fontSize: 16, 
              ),
            ), 
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(top: 0,),
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextButton(onPressed: null, 
              child: const Text("Get Started",
                style: TextStyle(
                  color: Color(0xffE4FCF9),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff4b89ac)),
              )
            ),
          )
        ],
      ),
      );
  }
}