import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Constants/input_form_field.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/login.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpContent extends StatefulWidget {
  _SignUpContent createState() => _SignUpContent();
}

class _SignUpContent extends State<SignUpContent> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userConfirmPass = TextEditingController();
  final userName = TextEditingController();
  final userPhone = TextEditingController();
  FirebaseUser currentUser;
  Country selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('90');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: AppBar(
        title: Text('Signup'),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
          inAsyncCall: loading,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Please Fill-up details '),
                  FormFeild(
                    controller: userName,
                    obsecure: false,
                    label: 'Name',
                    hint: 'Enter your name',
                    icon: Icons.person,
                  ),
                  FormFeild(
                    controller: userEmail,
                    obsecure: false,
                    label: 'Email',
                    inputType: TextInputType.emailAddress,
                    hint: 'Enter your Email',
                    icon: Icons.person,
                  ),
                  FormFeild(
                    controller: userPhone,
                    obsecure: false,
                    label: 'Phone',
                    inputType: TextInputType.number,
                    hint: 'Enter your phone',
                    icon: Icons.phone,
                  ),
                  FormFeild(
                    controller: userPassword,
                    obsecure: true,
                    label: 'Password',
                    hint: 'Enter your passwrod',
                    icon: Icons.lock,
                  ),
                  FormFeild(
                    controller: userConfirmPass,
                    obsecure: true,
                    label: 'Confirm Password',
                    hint: 'Enter your password',
                    icon: Icons.lock,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: CustomButton.roundedButton(
                      context,
                      background: secondaryColor,
                      txt: "Sign up".toUpperCase(),
                      onPress: () {
                        if (userPassword.text != userConfirmPass.text) {
                          Fluttertoast.showToast(msg: "Passwrod do not match");
                        } else {
                          _register(context);
                        }
                      },
                    ),
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
                        onTap: () {},
                        color: faceColor,
                      ),
                      ButtonImage(
                        image: 'assets/images/twitter.png',
                        onTap: null,
                        color: tweetColor,
                      ),
                      ButtonImage(
                        image: 'assets/images/google.png',
                        onTap: () async {},
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
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.grey[600])),
                          TextSpan(
                              text: ' Log In',
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
          )),
    );
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
        User.userData.userId = documents[0].documentID;
      }
      Fluttertoast.showToast(msg: "Sign in success");
      load(false);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainApp()));
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
            User.userData.userId = documents[0].documentID;
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

  void _register(context) async {
    if (userName.text.trim() == null || userName.text.trim() == ""){
      Fluttertoast.showToast(
        msg: 'Please enter name',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
      return;
    }

    if (userPhone.text.trim() == null || userPhone.text.trim() == ""){
      Fluttertoast.showToast(
        msg: 'Please enter mobile',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
      return;
    }
    load(true);
    if (userEmail.text.isNotEmpty) {
      try {
        FirebaseUser user = (await firebaseAuth.createUserWithEmailAndPassword(
                email: userEmail.text.trim(), password: userPassword.text))
            .user;
        print('${user.uid}');
        if (user != null) {
          await DatabaseServices(user.uid).addUserSignupData(
            null,
            userEmail.text.trim(),
            userName.text,
            userPhone.text.trim(),
          );
          User.userData.userId = user.uid.toString();
          FirebaseAuth.instance.signOut();
          load(false);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginContent()));
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

/*
try {
              Firestore.instance
                  .collection('Users')
                  .document(firebaseUser.uid)
                  .updateData({
                'id': firebaseUser.uid,
                'profile_photo': firebaseUser.photoUrl,
                'Email': firebaseUser.email,
                'Name': firebaseUser.displayName,
                'Mobile': firebaseUser.phoneNumber,
              });
            } catch (e) {
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
            }
 */