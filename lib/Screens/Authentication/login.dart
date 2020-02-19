import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/UserHome/Home.dart';
import 'package:hair_cos/Services/Authentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginView extends StatelessWidget {
  final Auth auth;

  LoginView({this.auth});
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  bool onSave = false;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Loading()
          : ModalProgressHUD(
              inAsyncCall: onSave,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextFormField(
                      controller: userEmail,
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
                      controller: userPassword,
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
                    child: CustomButton.roundedButton(context,
                        txt: "Login".toUpperCase(), onPress: () {
                      save(true);

                      _logIn();
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => forgotPass(context));
                      },
                      child: Text('Forgot Password'),
                    ),
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
                              //googleLogin(context);
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
                          /* dynamic result =
                          await widget.auth.signInAnon();
                      if (result == null) {
                        load(false);
                        print('error signing in');
                      } else {
                        print('signed in');
                        print(result.uid);
                        // creates user
                        
                        Navigator.of(context).pop();
                      } */
                        },
                        child: Text("Continue as Guest"),
                      ),
                    ),
                  ),
                ],
              )),
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

  Widget successDialogue(BuildContext context) {
    return Dialog(
      child: Container(
          padding: EdgeInsets.all(15.0),
          height: MediaQuery.of(context).size.width / 2,
          width: 300,
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Reset link has been set to your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(5)),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '   OK   ',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget forgotPass(BuildContext context) {
    return Dialog(
        child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.width / 1.2,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Enter the email address linked to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  width: 220,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: TextStyle(color: Colors.blueGrey),
                    cursorColor: Colors.blue,
                    textAlign: TextAlign.left,
                    controller: userEmail,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        hintStyle:
                            TextStyle(color: Colors.blueGrey, fontSize: 18)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(),
                  height: 40,
                  width: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    color: Colors.blueAccent,
                  ),
                  child: InkWell(
                      onTap: () {
                        if (userEmail.text == null || userEmail.text == '') {
                          Fluttertoast.showToast(
                            msg: 'Please enter an email',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                          );
                        } else {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(email: userEmail.text);
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (_) => successDialogue(context));
                        }
                      },
                      child: Text(
                        'Send reset link',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
              ],
            )));
  }

  void _logIn() async {
    if (userEmail.text.isNotEmpty) {
      try {
        await _firebaseAuth
            .signInWithEmailAndPassword(
                email: userEmail.text, password: userPassword.text)
            .then((onValue) async {
          User.userData.userId = onValue.user.uid;
          save(false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      } catch (signinError) {
        if (signinError.toString().contains("Given String is empty or null")) {
        } else if (signinError.toString().contains("ERROR_INVALID_EMAIL")) {
          Fluttertoast.showToast(
            msg: 'The email is invalid',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signinError);
        } else if (signinError.toString().contains("ERROR_USER_NOT_FOUND")) {
          Fluttertoast.showToast(
            msg: 'No user found with this email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signinError);
        } else if (signinError.toString().contains("ERROR_WRONG_PASSWORD")) {
          Fluttertoast.showToast(
            msg: 'wrong password try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signinError);
        } else if (signinError
            .toString()
            .contains("ERROR_EMAIL_ALREADY_IN_USE")) {
          Fluttertoast.showToast(
            msg: 'email entered is already in use.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signinError);
        } else {
          print(signinError);
        }
      }
    } else {
      save(false);
      Fluttertoast.showToast(
          msg: 'Please enter an email.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
    if (userPassword.text.isEmpty) {
      save(false);
      Fluttertoast.showToast(
          msg: 'Please enter password.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
  }

  /*  void googleLogin(context) async {
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
  } */

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

  void save(bool state) {
    setState(() {
      onSave = state;
    });
  }
}
