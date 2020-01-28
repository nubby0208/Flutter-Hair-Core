import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hair_cos/Models/User.dart';

class DatabaseServices {
  User user;

  void upDateUser(User _user) => user = _user;

  final CollectionReference usersCollection =
      Firestore.instance.collection("Users");

  DatabaseServices(this.user);

  Future editProfile(User user) async {
    try {
      return await usersCollection.document(user.uid).setData(
        {
          'Profile': {
            'Name': user.name,
            'Email': user.email,
            'Mobile': user.mobile,
            'Address': user.address,
          },
        },
      );
    } catch (e) {
      return null;
    }
  }

  Future getProfile(User user) async {
    try {} catch (e) {}
  }
}
