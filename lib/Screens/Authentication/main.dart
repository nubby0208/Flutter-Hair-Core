import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hair_cos/Screens/UserHome/NavBar.dart';
import 'package:hair_cos/Services/Authentication.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';


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
  // to access auth write container.database.auth
  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
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
          child: loginButtons(
            "LOGIN",
            Colors.blue,
            Colors.white,
            onPress: () {
              /*this is where login stuff goes*/
              container.updateUser(User(uid: "baokdnyeh73bh84hks"));
              container.database.getProfile(
                onData: (User user) {
                  user.anonymous = false;
                  container.updateUser(user);
                },
              );
              // opens home screen
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return navBar();
                },
              ), (e) => false);
            },
          ),
        ),
        Center(
          child: Text(
            "- or -",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: loginButtons(
            "Login with google",
            Colors.red,
            Colors.white,
            onPress: () {
             AuthenticationServices().testSignInWithGoogle().whenComplete(() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return navBar();
                    },
                  ),
                );
              });
            },
          ),
        ),
        loginButtons(
          "Login with facebook",
          Colors.indigo,
          Colors.white,
          onPress: () {
            /*this is where facebook stuff goes*/
          },
        ),
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
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: InkWell(
              onTap: () async {
                dynamic result = await container.database.auth.signInAnon();
                if (result == null) {
                  print('error signing in');
                } else {
                  print('signed in');
                  print(result.uid);

                  // creates user
                  container.updateUser(
                    User(
                      uid: result.uid,
                      anonymous: true,
                    ),
                  );
                  // opens home screen
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return navBar();
                    },
                  ), (e) => false);
                }
              },
              child: Text("Continue as Guest"),
            ),
          ),
        ),
      ],
    );
  }
}

class loginButtons extends StatelessWidget {
  final Color background;
  final String txt;
  final Color textColor;
  final Function onPress;

  loginButtons(this.txt, this.background, this.textColor, {this.onPress});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPress();
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
