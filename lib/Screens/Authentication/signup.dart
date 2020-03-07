import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/login.dart';
import 'package:hair_cos/Screens/ShopSignUp/ShopSignUp.dart';
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
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userConfirmPass = TextEditingController();
  bool onSave = false;
  FirebaseUser currentUser;

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
                    load(true);

                    _register();
                  }
                }),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            load(true);
                            facebookSignin(context);
                          },
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
              ],
            ));
  }

  void googleLogin(context) async {
    load(true);

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('Users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('Users')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'profile_photo': firebaseUser.photoUrl,
          'Email': firebaseUser.email,
          'Name': firebaseUser.displayName,
          'Mobile': firebaseUser.phoneNumber,
        });

        // Write data to local
        currentUser = firebaseUser;
        User.userData.userId = firebaseUser.uid;
      } else {
        // Write data to local
        User.userData.userId = documents[0].documentID;
      }
      Fluttertoast.showToast(msg: "Sign in success");
      load(false);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShopSignUp()));
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      load(false);
    }

    /* if (result == null) {
      
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ();
          }));
          return;
        }
      }

      Navigator.of(context).pop();
    } */
  }

  facebookSignin(BuildContext context) async {
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
        firebaseUser =
            (await firebaseAuth.signInWithCredential(credential)).user;
        print(firebaseUser);
        if (firebaseUser != null) {
          // Check is already sign up
          final QuerySnapshot result = await Firestore.instance
              .collection('Users')
              .where('id', isEqualTo: firebaseUser.uid)
              .getDocuments();
          final List<DocumentSnapshot> documents = result.documents;
          if (documents.length == 0) {
            // Update data to server if new user
            Firestore.instance
                .collection('Users')
                .document(firebaseUser.uid)
                .setData({
              'id': firebaseUser.uid,
              'profile_photo': firebaseUser.photoUrl,
              'Email': firebaseUser.email,
              'Name': firebaseUser.displayName,
              'Mobile': firebaseUser.phoneNumber,
            });

            // Write data to local
            currentUser = firebaseUser;
            User.userData.userId = firebaseUser.uid;
          } else {
            // Write data to local
            User.userData.userId = documents[0].documentID;
          }
          Fluttertoast.showToast(msg: "Sign in success");
          load(false);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShopSignUp()));
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
  }

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
        FirebaseUser user = (await firebaseAuth.createUserWithEmailAndPassword(
                email: userEmail.text, password: userPassword.text))
            .user;
        print('${user.uid}');
        if (user != null) {
          Firestore.instance
              .collection('Users')
              .document(user.uid.toString())
              .setData({
            'Email': userEmail.text.trim(),
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
          load(false);
          print(signupError);
        } else if (signupError.toString().contains("ERROR_INVALID_EMAIL")) {
          Fluttertoast.showToast(
            msg: 'The email is invalid',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          load(false);
          print(signupError);
        } else if (signupError.toString().contains("ERROR_WEAK_PASSWORD")) {
          Fluttertoast.showToast(
            msg: 'The password is too weak',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
          );
          load(false);
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
          load(false);
          print(signupError);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please enter an email.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
      load(false);
    }
  }

  void load(bool state) {
    setState(() {
      loading = state;
    });
  }
}
