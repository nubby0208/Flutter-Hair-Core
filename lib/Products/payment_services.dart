import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hair_cos/Models/User.dart';

class PaymentServices {
  addCard(token) {
    Firestore.instance
        .collection('cards')
        .document(User.userData.userId)
        .collection('tokens')
        .add({'tokenId': token}).then((val) {
      print('saved');
    });
  }
}
