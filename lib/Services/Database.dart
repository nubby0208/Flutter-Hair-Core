import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Storage.dart';

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
          'Name': user.name,
          'Email': user.email,
          'Mobile': user.mobile,
          'Address': user.address,
        },
      );
    } catch (e) {
      return null;
    }
  }

  void getProfile({Function onData}) async {
    usersCollection.document(user.uid).get().then((DocumentSnapshot snapshot) {
      onData(_toUser(snapshot));
    });
  }

  User _toUser(DocumentSnapshot snap) {
    return User(
      uid: user.uid,
      name: snap.data["Name"] ?? "No name",
      email: snap.data["Email"] ?? "No email",
      mobile: snap.data["Mobile"] ?? "No Mobile",
      address: snap.data["Address"] ?? "No Address",
      profileUrl: snap.data["ProfileUrl"],
    );
  }

  void uploadProfilePicture(File file) {
    StorageServices storage = StorageServices();
    storage.upLoadFile(
      image: file,
      onData: (profileUrl) {
        usersCollection.document(user.uid).setData(
          {
            'profileUrl': profileUrl,
          },
        );
      },
    );
  }
}
