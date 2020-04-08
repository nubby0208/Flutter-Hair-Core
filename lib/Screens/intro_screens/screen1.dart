import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Constants/styles.dart';
import 'package:hair_cos/Screens/Authentication/Welcome.dart';

class Intor1 extends StatelessWidget {
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        children: <Widget>[
          page1(context, size),
          page2(context, size),
          page3(context, size)
        ],
      ),
    );
  }

  Widget page1(context, size) {
    return Stack(
      children: <Widget>[
        Container(
          height: size.height / 1.34,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/s1.png'), fit: BoxFit.cover),
          ),
          child: Container(
            color: Colors.black.withOpacity(.3),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 30, right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen())),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.width / 1.7,
            width: size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Main Title',
                  style: title,
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur\n adipisicing elit, sed do eiusmod.',
                    textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.37),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: secondaryColor,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget page2(context, size) {
    return Stack(
      children: <Widget>[
        Container(
          height: size.height / 1.34,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/s2.png'), fit: BoxFit.cover),
          ),
          child: Container(
            color: Colors.black.withOpacity(.5),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 30, right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen())),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.width / 1.7,
            width: size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Main Title',
                  style: title,
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur\n adipisicing elit, sed do eiusmod.',
                    textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.37),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: secondaryColor,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget page3(context, size) {
    return Stack(
      children: <Widget>[
        Container(
          height: size.height / 1.34,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/s3.png'), fit: BoxFit.cover),
          ),
          child: Container(
            color: Colors.black.withOpacity(.3),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 30, right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen())),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.width / 1.7,
            width: size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Main Title',
                  style: title,
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur\n adipisicing elit, sed do eiusmod.',
                    textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.37),
          child: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen())),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: secondaryColor,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
