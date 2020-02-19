import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/Welcome.dart';
import 'package:hair_cos/Screens/UserHome/Home.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int login = 0;
  String id = "";
  getCurrentUser() async {
    try {
      id = await FirebaseAuth.instance.currentUser().then((onValue) {
        if (onValue.uid == null) {
          setState(() {
            login = 1;
            print('${onValue.uid} no online');
          });
        } else if (onValue.uid != null) {
          id = onValue.uid;
          print('$onValue  online');
          setState(() {
            login = 2;
            User.userData.userId = onValue.uid;
          });
          User.userData.userId = onValue.uid;
          _getUser();
        }
        return onValue.uid;
      });
    } catch (e) {
      print(e);
      setState(() {
        login = 1;
      });
      print("pppaaaaaa");
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      getCurrentUser();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (login == 0) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ));
    } else if (login == 2) {
      return Home();
    } else {
      return WelcomeScreen();
    }
  }

  void _getUser() async {
    final userdata = await Firestore.instance
        .collection("Users")
        .document(User.userData.userId)
        .get();
    setState(() {
      User.userData.name = userdata['Name'];
      User.userData.userEmail = userdata['Email'];
      User.userData.userNumber = userdata['Mobile'];
      User.userData.userPhoto = userdata['ProfileUrl'];
    });
    print('${User.userData.name}');
    print('${User.userData.userPhoto}');
  }
}
