import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Storage.dart';

import 'Authentication.dart';

class DatabaseServices {
  User user;
  final AuthenticationServices auth = AuthenticationServices();
  final StorageServices storage = StorageServices();

  void upDateUser(User _user) => user = _user;

  final CollectionReference usersCollection =
      Firestore.instance.collection("Users");

  DatabaseServices(this.user);

  Future editProfile(User user) async {
    try {
      return await usersCollection.document(this.user.uid).updateData(
        {
          'Name': user.name,
          'Email': user.email,
          'Mobile': user.mobile,
          'Address': user.address,
          'ProfileUrl': user.profileUrl,
        },
      );
    } catch (e) {
      try {
        return await usersCollection.document(this.user.uid).setData(
          {
            'Name': user.name,
            'Email': user.email,
            'Mobile': user.mobile,
            'Address': user.address,
            'ProfileUrl': user.profileUrl,
          },
        );
      } catch (ex) {
        print(ex);
      }
    }
  }

  void getProfile({Function onData}) async {
    usersCollection
        .document(this.user.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      onData(_toUser(snapshot));
    });
  }

  User _toUser(DocumentSnapshot snap) {
    return User(
      uid: this.user.uid,
      name: snap.data["Name"] ?? "No name",
      email: snap.data["Email"] ?? "No email",
      mobile: snap.data["Mobile"] ?? "No Mobile",
      address: snap.data["Address"] ?? "No Address",
      profileUrl: snap.data["ProfileUrl"],
    );
  }

  void uploadProfilePicture(File file, {Function onData}) {
    try {
      storage.upLoadFile(
        image: file,
        onData: (String profileUrl) {
          storage.deleteFile(this.user.profileUrl);
          onData(profileUrl);
          upLoadProfileName(profileUrl);
        },
      );
    } catch (e) {
      try {
        storage.upLoadFile(
          image: file,
          onData: (String profileUrl) {
            storage.deleteFile(this.user.profileUrl);
            onData(profileUrl);
            upLoadProfileName(profileUrl);
          },
        );
      } catch (ex) {
        print(ex);
      }
    }
  }

  Future upLoadProfileName(String url) async {
    try {
      return await usersCollection.document(this.user.uid).updateData(
        {
          'ProfileUrl': url,
        },
      );
    } catch (e) {
      try {
        return await usersCollection.document(this.user.uid).setData(
          {
            'ProfileUrl': url,
          },
        );
      } catch (ex) {}
    }
  }
}
