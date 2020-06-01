import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Constants/input_form_field.dart';
import 'package:hair_cos/Constants/styles.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/UserHome/NavBar.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: loading,
      child: Stack(
        children: <Widget>[
          picture(size),
          logo(size),
          Positioned(
            top: size.height / 7,
            right: size.width / 6,
            child: RichText(
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
          ),
          loginContent(context, size),
        ],
      ),
    ));
  }

  Widget logo(size) {
    return Positioned(
        top: size.height / 18,
        right: size.width / 2.2,
        child: Image.asset(
          'assets/images/logo.png',
          scale: 40,
        ));
  }

  Widget picture(size) {
    return Container(
      height: size.height / 2.5,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Container(
        color: Colors.black.withOpacity(.3),
      ),
    );
  }

  Widget loginContent(context, size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.width / .8,
        width: size.width,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Log In',
                style: title,
              ),
            ),
            FormFeild(
              controller: userEmail,
              obsecure: false,
              label: 'Email',
              hint: 'Enter your email',
              inputType: TextInputType.emailAddress,
              icon: Icons.email,
            ),
            FormFeild(
              controller: userPassword,
              obsecure: true,
              label: 'Passwrod',
              hint: 'Enter your Password',
              icon: Icons.lock,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context, builder: (_) => forgotPass(context));
                },
                child: Text('Forgot Password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: CustomButton.roundedButton(context,
                  background: secondaryColor,
                  txt: "Login".toUpperCase(), onPress: () {
                load(true);
                _logIn();

                // _logIn();
              }),
            ),
            Center(
              child: Text(
                'OR',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: <Widget>[
                ButtonImage(
                  image: 'assets/images/facebook.png',
                  onTap: () {
                    load(true);
                    facebookSignin(context);
                  },
                  color: faceColor,
                ),
                ButtonImage(
                  image: 'assets/images/twitter.png',
                  onTap: null,
                  color: tweetColor,
                ),
                ButtonImage(
                  image: 'assets/images/google.png',
                  onTap: () async {
                    googleLogin(context);
                  },
                  color: googleColor,
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginContent()));
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Don't have adn account? ",
                        style: TextStyle(color: Colors.grey[600])),
                    TextSpan(
                        text: ' Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            color: secondaryColor))
                  ])),
                ),
              ),
            ),
          ],
        ),
      ),
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
        await firebaseAuth
            .signInWithEmailAndPassword(
                email: userEmail.text, password: userPassword.text)
            .then((onValue) async {
          User.userData.userId = onValue.user.uid;
          User.userData
              .fromSnapshot(await DatabaseServices(onValue.user.uid).getUser());
          load(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainApp(),
              ),
              (Route<dynamic> route) => false);
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
          load(false);

          print(signinError);
        } else if (signinError.toString().contains("ERROR_USER_NOT_FOUND")) {
          Fluttertoast.showToast(
            msg: 'No user found with this email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          load(false);
          print(signinError);
        } else if (signinError.toString().contains("ERROR_WRONG_PASSWORD")) {
          Fluttertoast.showToast(
            msg: 'wrong password try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          load(false);
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
          load(false);
          print(signinError);
        } else {
          load(false);
          print(signinError);
        }
      }
    } else {
      load(false);
      Fluttertoast.showToast(
          msg: 'Please enter an email.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
    if (userPassword.text.isEmpty) {
      load(false);
      Fluttertoast.showToast(
          msg: 'Please enter password.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
  }

  void googleLogin(context) async {
    try {
      load(true);
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult auth = await firebaseAuth.signInWithCredential(credential);
      FirebaseUser firebaseUser = auth.user;

      if (firebaseUser != null) {
        if (auth.additionalUserInfo.isNewUser) {
          // Update data to server if new user
          await DatabaseServices(firebaseUser.uid).addUserSignupData(
            firebaseUser.photoUrl,
            firebaseUser.email,
            firebaseUser.displayName,
            firebaseUser.phoneNumber,
          );

          // Write data to local
          currentUser = firebaseUser;
          User.userData.userId = firebaseUser.uid;
        } else {
          // Write data to local
          User.userData.userId = firebaseUser.uid;
        }
        Fluttertoast.showToast(msg: "Sign in success");
        load(false);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainApp(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        load(false);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign in failed");
      load(false);
    }
  }

  void facebookSignin(BuildContext context) async {
    try {
      FirebaseUser firebaseUser;
      final facebookLogin = new FacebookLogin();
      facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

      final facebookLoginResult = await facebookLogin
          .logInWithReadPermissions(['email', 'public_profile']);

      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          print("Error");
          break;

        case FacebookLoginStatus.cancelledByUser:
          print("CancelledByUser");
          break;

        case FacebookLoginStatus.loggedIn:
          print("LoggedIn");
          AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: facebookLoginResult.accessToken.token);
          AuthResult auth = await firebaseAuth.signInWithCredential(credential);
          firebaseUser = auth.user;
          print(firebaseUser);
          if (firebaseUser != null) {
            // Check is already sign up
//          final QuerySnapshot result = await Firestore.instance
//              .collection('Users')
//              .where('id', isEqualTo: firebaseUser.uid)
//              .getDocuments();
//          final List<DocumentSnapshot> documents = result.documents;

            if (auth.additionalUserInfo.isNewUser) {
              // Update data to server if new user
              await DatabaseServices(firebaseUser.uid).addUserSignupData(
                firebaseUser.photoUrl,
                firebaseUser.email,
                firebaseUser.displayName,
                firebaseUser.phoneNumber,
              );

              // Write data to local
              currentUser = firebaseUser;
              User.userData.userId = firebaseUser.uid;
            } else {
              // Write data to local
              User.userData.userId = firebaseUser.uid;
            }
            Fluttertoast.showToast(msg: "Sign in success");
            load(false);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainApp()));
          } else {
            Fluttertoast.showToast(msg: "Sign in fail");
            load(false);
          }

          // final token = facebookLoginResult.accessToken.token;
          /* final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print(profile["email"]); */
          //await firebaseUser.updateEmail(profile["email"]);
          return null;
          break;
      }
    } catch (e){
      Fluttertoast.showToast(msg: "Sign in failed");
      load(false);
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

class ButtonImage extends StatelessWidget {
  final String image;
  final Color color;
  final Function onTap;

  ButtonImage(
      {@required this.image, @required this.color, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
          ),
          child: Image(
            image: AssetImage(image),
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
