import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hair_cos/Models/ShopUser.dart';
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
  final CollectionReference shopCollection =
      Firestore.instance.collection("Shops");

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

  Future getProfile({Function onData}) async {
    return await usersCollection
        .document(this.user.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      onData(_toUser(snapshot));
    });
  }

  User _toUser(DocumentSnapshot snap) {
    try {
      return User(
        uid: this.user.uid,
        name: snap.data["Name"] ?? "No name",
        email: snap.data["Email"] ?? "No email",
        mobile: snap.data["Mobile"] ?? "No Mobile",
        address: snap.data["Address"] ?? "No Address",
        profileUrl: snap.data["ProfileUrl"],
      );
    } catch (e) {
      return User(uid: null);
    }
  }

  void uploadProfilePicture(File file, {Function onData}) {
    try {
      _uploadProfile(file, onData: onData);
    } catch (e) {
      try {
        _uploadProfile(file, onData: onData);
      } catch (ex) {
        print(ex);
      }
    }
  }

  Future upLoadProfileName(String url) async {
    try {
      return await usersCollection.document(this.user.uid).updateData({
        'ProfileUrl': url,
      });
    } catch (e) {
      try {
        return await usersCollection.document(this.user.uid).setData({
          'ProfileUrl': url,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  void uploadShopProfile(File file,
      {@required Function onData, @required String sid}) {
    // upload picture for shop
    storage.upLoadFile(
      image: file,
      onData: (String profileUrl) {
        onData(profileUrl);
        _upLoadShopProfileName(profileUrl, sid);
      },
    );
  }

  Future _upLoadShopProfileName(String url, String sid) async {
    try {
      return await shopCollection.document(sid).updateData({
        'ProfileUrl': url,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'ProfileUrl': url,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  void _uploadProfile(File file, {Function onData}) {
    storage.upLoadFile(
      image: file,
      onData: (String profileUrl) {
        storage.deleteFile(this.user.profileUrl);
        onData(profileUrl);
        upLoadProfileName(profileUrl);
      },
    );
  }

  Future upLoadShopName({String sid, String name}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'ShopName': name,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'ShopName': name,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future upLoadShopAddress({String sid, String address}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'ShopAddress': address,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'ShopAddress': address,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future upLoadShopEmail({String sid, String email}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'ShopEmail': email,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'ShopEmail': email,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future upLoadShopContact({String sid, String contact}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'ShopContact': contact,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'ShopContact': contact,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future getShopProfile(String sid, {Function onData}) {
    return shopCollection.document(sid).get().then((DocumentSnapshot snapShot) {
      onData(_toShopUser(snapShot));
    });
  }

  ShopUser _toShopUser(DocumentSnapshot snapshot) {
    try {
      return ShopUser(
        sid: snapshot.documentID,
        name: snapshot.data["ShopName"] ?? "No Shop Name",
        address: snapshot.data["ShopAddress"] ?? "No Shop Address",
        email: snapshot.data["ShopEmail"] ?? "No Shop Email",
        contact: snapshot.data["ShopContact"] ?? "No Shop Contact",
      );
    } catch (e) {
      return null;
    }
  }
}
