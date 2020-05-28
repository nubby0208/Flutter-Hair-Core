import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:hair_cos/Models/User.dart';

abstract class BaseDatabaseServices {
  Future addUserProfilePicture(File file);

  Future addUserName(String name);

  Future addUserMobile(String countryCode, String mobile);

  Future addUserAddress(
      {postcode, street, city, region, GeoFirePoint geoPoint});

  Future<DocumentSnapshot> getUser();

  Stream<List<Map>> get independentServices;

  Future addUserSignupData(
      String profilephoto, String email, String name, String mobile);
}

class DatabaseServices implements BaseDatabaseServices {
  String uid;
  CollectionReference _userCollection = Firestore.instance.collection('Users');
  DocumentReference _independentServicesCollection = Firestore.instance
      .collection('Services')
      .document("mobile_8npEQWDGQJUbHqUb9xAW");

  StorageReference _userProfileRef;

  DatabaseServices(this.uid) {
    _userProfileRef =
        FirebaseStorage.instance.ref().child('Images/Users/${this.uid}/');
  }

  @override
  Future addUserProfilePicture(File file) async {
    try {
      if (User.userData.userPhoto != null)
        FirebaseStorage.instance
            .getReferenceFromUrl(User.userData.userPhoto)
            .then(
          (StorageReference ref) {
            if (ref != null) ref.delete();
          },
        );
    } on Exception catch (e) {
      //
    }
    StorageReference storageReference = _userProfileRef
        .child('${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');

    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    String url = await storageReference.getDownloadURL();

    try {
      return await _userCollection.document(this.uid).updateData(
        {
          'ProfilePhoto': url,
        },
      );
    } catch (e) {
      return await _userCollection.document(this.uid).setData(
        {
          'ProfilePhoto': url,
        },
      );
    }
  }

  @override
  Future addUserName(String name) async {
    try {
      return await _userCollection.document(this.uid).updateData(
        {
          'Name': name,
        },
      );
    } catch (e) {
      return await _userCollection.document(this.uid).setData(
        {
          'Name': name,
        },
      );
    }
  }

  @override
  Future addUserMobile(String countryCode, String mobile) async {
    try {
      return await _userCollection.document(this.uid).updateData(
        {
          'Contact': {
            'Contact': mobile,
            'PhoneCode': countryCode,
          },
        },
      );
    } catch (e) {
      return await _userCollection.document(this.uid).setData(
        {
          'Contact': {
            'Contact': mobile,
            'PhoneCode': countryCode,
          },
        },
      );
    }
  }

  @override
  Future addUserAddress(
      {postcode, street, city, region, GeoFirePoint geoPoint}) async {
    try {
      return await _userCollection.document(this.uid).updateData(
        {
          'Address': {
            'Street': street,
            'Postcode': postcode,
            'City': city,
            'Region': region,
          },
          'Position': geoPoint.data,
        },
      );
    } catch (e) {
      return await _userCollection.document(this.uid).setData(
        {
          'Address': {
            'Street': street,
            'Postcode': postcode,
            'City': city,
            'Region': region,
          },
          'Position': geoPoint.data,
        },
      );
    }
  }

  @override
  Future<DocumentSnapshot> getUser() async {
    return await _userCollection.document(this.uid).get();
  }

  @override
  Stream<List<Map>> get independentServices {
    return _independentServicesCollection.snapshots().map(_toList);
  }

  List<Map> _toList(DocumentSnapshot documentSnapshot) {
    try {
      if (documentSnapshot == null ||
          documentSnapshot.data == null ||
          documentSnapshot.data['Services'] == null) return [];
      List<Map> res = [];
      documentSnapshot.data['Services'].forEach((val) {
        Map m = {};
        val.forEach((k, v) {
          m[k] = v;
        });
        res.add(m);
      });
      return res;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future addUserSignupData(
      String profilephoto, String email, String name, String mobile) async {
    try {
      return await _userCollection.document(this.uid).updateData({
        'id': this.uid,
        'ProfilePhoto': profilephoto,
        'Email': email,
        'Name': name,
        'Contact': {
          'Contact': mobile,
          'PhoneCode': '44',
        },
      });
    } catch (e) {
      return await _userCollection.document(this.uid).setData({
        'id': this.uid,
        'ProfilePhoto': profilephoto,
        'Email': email,
        'Name': name,
        'Contact': {
          'Contact': mobile,
          'PhoneCode': '44',
        },
      });
    }
  }
}
