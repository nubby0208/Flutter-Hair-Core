import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Screens/ShopSignUp/ShopSignUp.dart';
import 'package:hair_cos/Screens/Authentication/login.dart';
import 'package:hair_cos/Screens/Authentication/signup.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int state = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundImage(),
          welcomeContent(context),
        ],
      ),
    );
  }

  Widget backgroundImage() {
    return Center(
      child: Image.asset(
        "asserts/barber_home_pic.jpg",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
        color: Colors.blue.withOpacity(0.7),
        colorBlendMode: BlendMode.softLight,
      ),
    );
  }

  Widget welcomeContent(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: CustomButton.roundedButton(
                context,
                txt: "Login".toUpperCase(),
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return loginView();
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: CustomButton.roundedButton(
                context,
                txt: "Signup".toUpperCase(),
                background: Colors.white,
                textColor: Colors.black,
                borderColor: Theme.of(context).primaryColor,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: CustomButton.roundedButton(
                context,
                txt: "Bussiness signup".toUpperCase(),
                background: Colors.white,
                textColor: Colors.black,
                borderColor: Theme.of(context).primaryColor,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUp(shopSignUp: true,);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
      ),
    );
  }

  Widget loginButtons({txt, background, textColor, onPress, borderColor}) {
    return RaisedButton(
      onPressed: () {
        onPress();
      },
      color: background,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: borderColor ?? background, width: 3),
      ),
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
