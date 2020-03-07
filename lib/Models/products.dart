class Product {
  static final Product _singleton = Product._internal();
  factory Product() => _singleton;
  Product._internal();
  static Product get productData => _singleton;
  String docid;
  String title;
  String description;
  String price;
  String instock;
  List<dynamic> pictures = List<dynamic>();
  List<PList> cart = List<PList>();
}

class PList {
  String photo = '';
  String title = '';
  String description = '';
  String price = '';
  PList({this.description, this.price, this.title, this.photo});
}
