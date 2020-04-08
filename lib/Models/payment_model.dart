class Payment {
  static final Payment _singleton = Payment._internal();
  factory Payment() => _singleton;
  Payment._internal();
  static Payment get paymentData => _singleton;
  String package;
  String price;
  String text;
}
