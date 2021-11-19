import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../../utils/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardTop extends StatefulWidget {
  const DashboardTop({Key? key}) : super(key: key);

  @override
  _DashboardTopState createState() => _DashboardTopState();
}

class _DashboardTopState extends State<DashboardTop> {
  void signOutHandler(context) {
    print('Signout');
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double _viewWidth(double percent) {
      return MediaQuery.of(context).size.width * percent;
    }

    return Container(
        color: Color(0xff4B89AC),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                height: _viewWidth(0.40),
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  "assets/images/corner_circles.png",
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                )),
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg"),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 210),
              child: GestureDetector(
                onTap: () {
                  signOutHandler(context);
                },
                child: Text(
                  'Welcome, Alan Pisano',
                  style: const TextStyle(
                      color: Color(0xffE4FCF9),
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ],
        ),
        height: 250);
  }
}
