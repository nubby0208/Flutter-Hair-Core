import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Screens/UserHome/NavBar.dart';
import 'package:hair_cos/splash_screen.dart';

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: secondaryColor,
        accentColor: Colors.indigo,
        cursorColor: secondaryColor,
        fontFamily: 'Gilroy',
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBar(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: secondaryColor,
        accentColor: Colors.indigo,
        cursorColor: secondaryColor,
        fontFamily: 'Gilroy',
      ),
    );
  }
}
