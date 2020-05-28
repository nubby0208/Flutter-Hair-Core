import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  static final User _singleton = User._internal();
  factory User() => _singleton;
  User._internal();
  static User get userData => _singleton;
  String name;
  String userEmail;
  String userNumber;
  String countryCode;
  String userId;
  String street;
  String postcode;
  String city;
  String region;
  String userPhoto;
  String address;
  bool login;
  String stripeId;

  void fromSnapshot(DocumentSnapshot snapshot) {
    reset();
    name = snapshot.data['Name'];
    userEmail = snapshot.data['Email'];
    if (snapshot.data['Contact'] != null) {
      userNumber = snapshot.data['Contact']['Contact'];
      countryCode = snapshot.data['Contact']['PhoneCode'];
    }
    userId = snapshot.documentID;
    if (snapshot.data['Address'] != null) {
      street = snapshot.data['Address']['Street'];
      postcode = snapshot.data['Address']['Postcode'];
      city = snapshot.data['Address']['City'];
      region = snapshot.data['Address']['Region'];
    }
    userPhoto = snapshot.data['ProfilePhoto'];
    stripeId = snapshot.data['stripeId'];
  }

  void reset(){
    name = "";
    userEmail = "";
    userNumber = "";
    countryCode = "";
    userId = "";
    street = "";
    postcode = "";
    city = "";
    region = "";
    userPhoto = "";
    stripeId = "";
  }
}
