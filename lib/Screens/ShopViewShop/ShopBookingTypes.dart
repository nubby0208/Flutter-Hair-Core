import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/ExpandableView.dart';
import 'package:hair_cos/Models/BookingType.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopEditBookingType.dart';

class ShopBookingTypes extends StatefulWidget {
  @override
  _ShopBookingTypesState createState() => _ShopBookingTypesState();
}

class _ShopBookingTypesState extends State<ShopBookingTypes> {
  Map<String, List<BookingType>> bookingType = {};
  var categories = [];

  @override
  void initState() {
    super.initState();
    categories = ["Mens", "Kids", "Women"];
    for (int i = 0; i < categories.length; i++) {
      for (int j = 0; j < 3; j++) {
        if (bookingType[categories[i]] != null)
          bookingType[categories[i]].add(
            BookingType(
              category: categories[i],
              name: j % 2 == 0 ? "Mens Cut" : "Kids Cut",
              duration: 45,
              price: Price(amount: 15, currency: "£"),
            ),
          );
        else
          bookingType[categories[i]] = [
            BookingType(
              category: categories[i],
              name: j % 2 == 0 ? "Mens Cut" : "Kids Cut",
              duration: 45,
              price: Price(amount: 15, currency: "£"),
            ),
          ];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Types"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpandableView(
            title: Text(categories[index]),
            expanded: subTitles(bookingType[categories[index]]),
            isExpanded: index == 0 ? true : false,
          );
        },
        itemCount: categories.length,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text("Add Booking Type"),
      ),
    );
  }

  Widget subTitles(List<BookingType> list) {
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) {
                  return ShopEditBookingType(
                    bookingType: list[i],
                  );
                },
              ),
            );
          },
          title: Text(
            "${list[i].name}",
          ),
          subtitle: Text(
            "${list[i].duration}min | "
            "${list[i].price.currency}${list[i].price.amount}",
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      );
      widgets.add(
        Divider(
          color: Colors.black,
        ),
      );
    }
    return Column(
      children: widgets,
    );
  }
}
