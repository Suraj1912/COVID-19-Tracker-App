import 'package:covid19/homepage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      title: Text(
        'Corona Tracker',
        style: TextStyle(
            fontSize: 40,
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      imageBackground: AssetImage('assets/bg.jpg'),
      image: Image.asset(
        'assets/covid19.png',
      ),
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100,
      loaderColor: Colors.red,
      navigateAfterSeconds: HomePage(),
    );
  }
}
