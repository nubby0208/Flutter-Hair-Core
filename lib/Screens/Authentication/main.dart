import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import '../UserHome/NavBar.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateContainer(
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: loginView(),
        ),
      ),
      database: DatabaseServices(
        User(uid: "1bibekb4bdkbids"),
      ),
    );
  }
}

class loginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: SvgPicture.asset(
                'asserts/logo.svg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: loginContent(),
            ),
          )
        ],
      ),
    );
  }
}

class loginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: loginButtons("LOGIN", Colors.blue, Colors.white),
        ),
        Center(
          child: Text(
            "- or -",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: loginButtons("Login with google", Colors.red, Colors.white),
        ),
        loginButtons("Login with facebook", Colors.indigo, Colors.white),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return signup();
                    },
                  ),
                );
              },
              child: Text("No Account? Sign up"),
            ),
          ),
        )
      ],
    );
  }
}

class loginButtons extends StatelessWidget {
  final Color background;
  final String txt;
  final Color textColor;

  loginButtons(this.txt, this.background, this.textColor);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return RaisedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Logging in"),
              content: Text("Press continue if you would like to login"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
                FlatButton(
                  onPressed: () {
                    container.updateUser(User(uid: "baokdnyeh73bh84hks"));
                    container.database.getProfile(onData: (User user) {
                      container.updateUser(user);
                    });

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return navBar();
                      },
                    ), (e) => false);
                  },
                  child: Text("Continue"),
                )
              ],
            );
          },
        );
      },
      color: background,
      splashColor: Colors.grey,
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
// MediaQuery.of(context).size.width;
