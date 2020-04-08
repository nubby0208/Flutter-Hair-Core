import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
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
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/welcome.png"),
                            fit: BoxFit.cover)),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(''),
                        Align(alignment: Alignment.center, child: textArea()),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {},
                            child: welcomeContent(context),
                          ),
                        ),
                      ],
                    ))));
      }),
    );
  }

  /* Widget backgroundImage() {
    return Center(
      child: Image.asset(
        ,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
        color: Colors.black.withOpacity(0.5),
        colorBlendMode: BlendMode.softLight,
      ),
    );
  } */

  Widget textArea() {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          scale: 30,
        ),
        SizedBox(height: 10),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Inertia',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy')),
          TextSpan(
              text: ' Cosmetics',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                  color: secondaryColor))
        ])),
        Text(
          'Lorem ipsum dolor sit amet, consectetur\n adipisicing elit, sed do eiusmod.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  Widget welcomeContent(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          CustomButton.roundedButton(
            context,
            background: secondaryColor,
            textColor: Colors.black,
            txt: "Login".toUpperCase(),
            onPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LoginContent();
                  },
                ),
              );
            },
          ),
          SizedBox(height: 10),
          CustomButton.roundedButton(
            context,
            txt: "Signup".toUpperCase(),
            background: Colors.transparent,
            borderColor: secondaryColor,
            onPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpContent();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
