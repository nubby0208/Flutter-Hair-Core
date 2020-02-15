import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hair_cos/Models/ShopSignupData.dart';
import 'package:hair_cos/Models/ShopUser.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Storage.dart';

import 'Authentication.dart';

class DatabaseServices {
  User user;
  ShopUser shopUser = new ShopUser();

  final AuthenticationServices auth = AuthenticationServices();
  final StorageServices storage = StorageServices();

  void upDateUser(User _user) => user = _user;

  final CollectionReference usersCollection =
      Firestore.instance.collection("Users");
  final CollectionReference shopCollection =
      Firestore.instance.collection("Shops");
  final CollectionReference newShopCollection =
      Firestore.instance.collection("NewShops");

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
    return User(
      uid: snap.documentID,
      name: getString(snap, "Name"),
      email: getString(snap, "Email"),
      mobile: getString(snap, "Mobile"),
      address: getString(snap, "Address"),
      profileUrl: getString(snap, "ProfileUrl"),
      sid: getString(snap, "sid"),
    );
  }

  String getString(DocumentSnapshot snap, String map) {
    try {
      return snap.data[map];
    } catch (e) {
      return null;
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
        'Address': address,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'Address': address,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future upLoadShopAbout({String sid, String text}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'About': text,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'About': text,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future upLoadShopEmail({String sid, String email}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'Email': email,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'Email': email,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  Future upLoadShopContact({String sid, String contact}) async {
    try {
      return await shopCollection.document(sid).updateData({
        'Contact': contact,
      });
    } catch (e) {
      try {
        return await shopCollection.document(sid).setData({
          'Contact': contact,
        });
      } catch (ex) {
        return null;
      }
    }
  }

  void upLoadShopImage(
      {String sid, File image, Function onData, prevUrl}) async {
    try {
      storage.upLoadFile(
        image: image,
        onData: (String profileUrl) {
          storage.deleteFile(prevUrl);
          onData(profileUrl);
          _upLoadShopProfileName(profileUrl, sid);
        },
      );
    } catch (e) {
      try {
        storage.upLoadFile(
          image: image,
          onData: (String profileUrl) {
            storage.deleteFile(prevUrl);
            onData(profileUrl);
            _upLoadShopProfileName(profileUrl, sid);
          },
        );
      } catch (ex) {
        print(ex);
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
        address: snapshot.data["Address"] ?? "No Shop Address",
        email: snapshot.data["Email"] ?? "No Shop Email",
        contact: snapshot.data["Contact"] ?? "No Shop Contact",
      );
    } catch (e) {
      return null;
    }
  }

  Stream<DocumentSnapshot> get shopProfile {
    return shopCollection.document(shopUser.sid).snapshots();
  }

  Stream<User> get userProfile {
    return usersCollection.document(user.uid).snapshots().map(_toUser);
  }

  Future signUpShop(ShopSignUpData signUpData) async {
    QuerySnapshot data = await newShopCollection.where("CreatorID", isEqualTo: signUpData.creatorID).getDocuments();
    if (data.documents.isEmpty){
      return null;
    }
    return newShopCollection.add(signUpData.toJson());
  }
}

class DatabaseShopServices extends DatabaseServices {
  DatabaseShopServices(User user) : super(user);

  void searchShops({String text, Function onData}) async {
    if (text == "Independant Owners"){
      await shopCollection
          .where("Indipendant", isEqualTo: true)
          .getDocuments()
          .then(
            (QuerySnapshot snap) {
          onData(snap);
        },
      );
    }else {
      await shopCollection
          .where("Type", arrayContains: text)
          .getDocuments()
          .then(
            (QuerySnapshot snap) {
          onData(snap);
        },
      );
    }
  }
}
