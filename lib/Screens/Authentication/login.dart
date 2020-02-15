import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Authentication.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class loginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                height: MediaQuery.of(context).size.height * 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: LoginContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return loading
        ? Loading()
        : ListView(
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
                padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
                child: CustomButton.roundedButton(context, txt: "Login".toUpperCase()),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.facebookSquare,
                          color: Colors.indigo,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          googleLogin(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      load(true);
                      dynamic result =
                          await container.database.auth.signInAnon();
                      if (result == null) {
                        load(false);
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
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Continue as Guest"),
                  ),
                ),
              ),
            ],
          );
  }

  void errorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void googleLogin(context) async {
    final container = StateContainer.of(context);
    load(true);
    dynamic result = await AuthenticationServices().testSignInWithGoogle();
    if (result == null) {
      load(false);
      errorDialog("Error signing in", context);
    } else {
      FirebaseUser user = result.user;
      container.updateUser(User(uid: user.uid));
      if (result.additionalUserInfo.isNewUser) {
        User tempUser = User(
          uid: user.uid,
          email: user.email,
          name: user.displayName,
          profileUrl: user.photoUrl,
          mobile: user.phoneNumber,
        );
        container.database.editProfile(tempUser);
        container.updateUser(tempUser);
      } else {
        container.database.getProfile(
          onData: (User user) {
            container.updateUser(user);
          },
        );
      }
      Navigator.of(context).pop();
    }
  }

  Widget loginButtons({txt, background, textColor, onPress}) {
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

  void load(bool state) {
    setState(() {
      loading = state;
    });
  }
}
