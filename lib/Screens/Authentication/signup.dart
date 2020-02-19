import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatelessWidget {
  final bool shopSignUp;
  SignUp({this.shopSignUp});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: SvgPicture.asset(
                'asserts/logoReverse.svg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
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
                child: SignUpContent(
                  shopSignUp: shopSignUp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpContent extends StatefulWidget {
  final bool shopSignUp;
  SignUpContent({this.shopSignUp});

  _SignUpContent createState() => _SignUpContent();
}

class _SignUpContent extends State<SignUpContent> {
  bool loading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userConfirmPass = TextEditingController();
  bool onSave = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : ModalProgressHUD(
            inAsyncCall: onSave,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: userConfirmPass,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "By pressing sign up you agree to the terms and conditions",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
                CustomButton.roundedButton(context,
                    txt: "Sign up".toUpperCase(), onPress: () {
                  if (userPassword.text != userConfirmPass.text) {
                    Fluttertoast.showToast(
                      msg: 'Password does not match ',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                    );
                  } else {
                    save(true);

                    _register();
                  }
                }),
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
              ],
            ));
  }

  /* void googleLogin(context) async {
    final container = StateContainer.of(context);
    load(true);
    dynamic result = await AuthenticationServices().testSignInWithGoogle();
    if (result == null) {
      load(false);
      errorDialog("Error signing in", context);
    } else {
      FirebaseUser user = result.user;
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
      if (widget.shopSignUp != null) {
        if (widget.shopSignUp == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return ShopSignUp();
          }));
          return;
        }
      }

      Navigator.of(context).pop();
    }
  } */

  void save(bool state) {
    setState(() {
      onSave = state;
    });
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

  void _register() async {
    if (userEmail.text.isNotEmpty) {
      try {
        FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
                email: userEmail.text, password: userPassword.text))
            .user;
        print('${user.uid}');
        if (user != null) {
          Firestore.instance.collection('Users').document(user.uid).setData({
            'Email': userEmail.text,
            'profile_photo': "",
          });
          User.userData.userId = user.uid.toString();
          FirebaseAuth.instance.signOut();
          save(false);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginView()));
        }
      } catch (signupError) {
        if (signupError.toString().contains("Given String is empty or null")) {
        } else if (signupError.toString().contains("ERROR_WRONG_PASSWORD")) {
          Fluttertoast.showToast(
            msg: 'The password is invalid',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signupError);
        } else if (signupError.toString().contains("ERROR_INVALID_EMAIL")) {
          Fluttertoast.showToast(
            msg: 'The email is invalid',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signupError);
        } else if (signupError.toString().contains("ERROR_WEAK_PASSWORD")) {
          Fluttertoast.showToast(
            msg: 'The password is too weak',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signupError);
        } else if (signupError
            .toString()
            .contains("ERROR_EMAIL_ALREADY_IN_USE")) {
          Fluttertoast.showToast(
            msg: 'The email address is already in use.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          print(signupError);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please enter an email.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
  }

  void load(bool state) {
    setState(() {
      loading = state;
    });
  }
}
