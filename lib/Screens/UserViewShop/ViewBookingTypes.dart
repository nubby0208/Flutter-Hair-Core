import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/ExpandableView.dart';
import 'package:hair_cos/Screens/UserViewShop/MakeBooking.dart';

class ViewBookingTypes extends StatefulWidget {
  _ViewBookingTypes createState() => _ViewBookingTypes();
}

class _ViewBookingTypes extends State<ViewBookingTypes> {
  var tittles = ["Men's cut", "Kid's cut", "Women's cut"];
  var types = ["Hair cut", "Beard cut", "Hairline"];
  List<BookingTypes> list = List<BookingTypes>();

  @override
  Widget build(BuildContext context) {
    list = List<BookingTypes>();
    for (int i = 0; i < tittles.length; i++) {
      BookingTypes temp = BookingTypes();
      temp.addToList(types, context);
      temp.title = tittles[i];
      list.add(temp);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Types"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpandableView(
            title: Text(list[index].title),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list[index].list,
            ),
            isExpanded: index == 0 ? true : false,
          );
        },
      ),
    );
  }
}

class BookingTypes {
  final images = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg",
  ];
  String title = "";
  List<Widget> list = List<Widget>();
  BuildContext context;

  void addToList(var arr, BuildContext context) {
    for (int i = 0; i < arr.length; i++) {
      list.add(InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // BookingInfo info = new BookingInfo();
              return MakeBooking(
                bookingInfo: arr[i],
              );
            }));
          },
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        arr[i],
                        style: TextStyle(fontSize: 20),
                      ),
                      Text("45mins | £15"),
                    ]),
                Spacer(),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MakeBooking(
                        bookingInfo: arr[i],
                      );
                    }));
                  },
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: Colors.blue,
                  child: Text(
                    "Book",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            CustomExpandableView(
              title:
                  Text("Preview style", style: TextStyle(color: Colors.blue)),
              expandedTitle:
                  Text("Close style", style: TextStyle(color: Colors.blue)),
              expanded: SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              bringupdialog(context, images[index]);
                            },
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Column(children: <Widget>[
                                  ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      child: Image.asset(
                                        images[index],
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ))
                                ])));
                      })),
              isExpanded: false,
            )
          ])));
      list.add(Divider(
        color: Colors.black,
      ));
    }
  }

  void bringupdialog(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.white,
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
                        ))),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
