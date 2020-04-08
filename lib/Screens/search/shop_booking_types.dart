import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/ExpandableView.dart';
import 'package:hair_cos/Models/BookingType.dart';
import 'package:hair_cos/Screens/search/booking_time.dart';
import 'package:hair_cos/Screens/search/shop_edit_booking_types.dart';

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
    categories = ["Men's Cut", "Kid's", "Women's Cut"];
    for (int i = 0; i < categories.length; i++) {
      for (int j = 0; j < 3; j++) {
        if (bookingType[categories[i]] != null)
          bookingType[categories[i]].add(
            BookingType(
              category: categories[i],
              name: j % 2 == 0 ? "Mens Cut" : "Hair Cut",
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
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ExpandableView(
                title: Text(
                  categories[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                expanded: subTitles(bookingType[categories[index]]),
                isExpanded: index == 0 ? true : false,
              );
            },
            itemCount: categories.length,
          ),
        ),
      ]),
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
          title: Text("${list[i].name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "${list[i].duration}min | "
                    "${list[i].price.currency}${list[i].price.amount}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                    fontSize: 13)),
            TextSpan(text: '\n'),
            TextSpan(
                text: 'Preview Style',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                    decoration: TextDecoration.underline)),
          ])),
          trailing: Container(
              width: 80,
              height: 30,
              child: CustomButton.roundedButton(
                context,
                fontsize: 10.0,
                onPress: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookingTime())),
                txt: "Book",
                textColor: Colors.black,
                background: secondaryColor,
              )),
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
