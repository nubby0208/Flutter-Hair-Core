import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/ShopHome/ShopNavBar.dart';
import 'package:hair_cos/Screens/ShopHome/ShopOwnerProfile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class signup extends StatelessWidget {
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
                height: MediaQuery.of(context).size.height * 0.75,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: signupContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class signupContent extends StatefulWidget {
  _signupContent createState() => _signupContent();
}

class _signupContent extends State<signupContent> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
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
        Row(children: <Widget>[
          Checkbox(
              value: checkValue,
              onChanged: (bool value) {
                setState(() {
                  checkValue = value;
                });
              }),
          Text("Do you want an account as a shop owner")
        ]),
        Text(
          "By pressing sign up you agree to the terms and conditions",
          style: TextStyle(color: Colors.indigo),
        ),
        SignInButtons("Sign up", Colors.blue, Colors.white),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Center(
              child: Text(
                "Have an account? Sign in",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SignInButtons extends StatelessWidget {
  final Color background;
  final String txt;
  final Color textColor;

  SignInButtons(this.txt, this.background, this.textColor);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return RaisedButton(
      onPressed: () {
        container.updateUser(User(uid: "bagojvkdnyeh73bh84hks"));
        container.database.getProfile(onData: (user) {
          container.updateUser(user);
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ShopNavBar();
            },
          ),
          (e) => false,
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
