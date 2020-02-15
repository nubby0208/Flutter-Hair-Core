import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:hair_cos/Models/ShopUser.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/ShopHome/ShopNavBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hair_cos/Screens/ShopSignUp/ShopSignUp.dart';
import 'package:hair_cos/Services/Authentication.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

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
                child: SignUpContent(shopSignUp: shopSignUp,),
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
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: TextFormField(
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
          padding: const EdgeInsets.fromLTRB(0,5,0,10),
          child: Text(
            "By pressing sign up you agree to the terms and conditions",
            style: TextStyle(color: Colors.indigo),
          ),
        ),
        CustomButton.roundedButton(context, txt: "Sign up".toUpperCase()),
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
      ],
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

  void load(bool state) {
    setState(() {
      loading = state;
    });
  }
}