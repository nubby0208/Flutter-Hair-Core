import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/Authentication/rootPage.dart';


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
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        
        resizeToAvoidBottomPadding: false,
        body: RootPage(),
      ),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.blue[900],
        accentColor: Colors.indigo,
        // Define the default font family.
        fontFamily: 'Georgia',
      ),
    );
  }
}

// MediaQuery.of(context).size.width;
