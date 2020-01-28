class BookingType{
  String category;
  String name;
  Price price;
  int duration;
  BookingType({this.category, this.name, this.price, this.duration});
}

class Price{
  int amount;
  String currency;
  Price({this.amount, this.currency});
}