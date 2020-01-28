import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/BookingType.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';

class ShopEditBookingType extends StatefulWidget {
  BookingType bookingType;
  ShopEditBookingType({@required this.bookingType});

  @override
  _ShopEditBookingTypeState createState() => _ShopEditBookingTypeState();
}

class _ShopEditBookingTypeState extends State<ShopEditBookingType> {
  List<String> categories = ["Mens", "Kids", "Women"];
  String currentCategory;

  @override
  void initState() {
    super.initState();
    currentCategory = widget.bookingType.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Booking Type"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditDetails(
                      type: "Booking Name",
                      text: widget.bookingType.name,
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.person),
            title: Text("Name"),
            subtitle: Text(widget.bookingType.name),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditDetails(
                      type: "Booking Duration",
                      text: "${widget.bookingType.duration.toString()}mins",
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.access_time),
            title: Text("Duration"),
            subtitle: Text("${widget.bookingType.duration}min"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditDetails(
                      type: "Booking Price",
                      text: "${widget.bookingType.price.currency}"
                          "${widget.bookingType.price.amount}",
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.attach_money),
            title: Text("Price"),
            subtitle: Text(
                "${widget.bookingType.price.currency}${widget.bookingType.price.amount}"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text("Category"),
            subtitle: DropdownButton(
              hint: Text("Please enter a category"),
              value: currentCategory,
              onChanged: (newValue) {
                setState(() {
                  currentCategory = newValue;
                });
              },
              items: categories.map((pos) {
                return DropdownMenuItem(
                  child: Text(pos),
                  value: pos,
                );
              }).toList(),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.blue,
                child: Container(
                    height: 50,
                    child: Center(
                        child: Text("Save",
                            style: TextStyle(color: Colors.white)))),
              ))
        ],
      ),
    );
  }

  Widget paddedDivider() {
    return Divider(
      color: Colors.black,
      indent: 50,
    );
  }
}
