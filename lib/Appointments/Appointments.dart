import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/AppointmentsTile.dart';

class Appointments extends StatefulWidget {
  _Appointments createState() => _Appointments();
}

class _Appointments extends State<Appointments> {
  final profileImages = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg",
    "asserts/barber_pic_2.jpg",
  ];
  final bookingTypes = [
    "Beard Trim",
    "Men's Haircut",
    "Men's Haircut",
    "Kid's Cut"
  ];
  final timeDate = [
    "Wed, 8/04/2020 | 11:00",
    "Mon, 20/04/2020 | 11:00",
    "Mon, 08/06/2020 | 13:00",
    "Mon, 15/06/2020 | 13:00"
  ];

  final names = ["Mzimkhulu ncube", "Josh murfey", "Josh radnor", "Ted Mosby"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Appointments"),
        ),
        body: list());
  }

  Widget list() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(10),
              child: AppointmentsTile(
                width: MediaQuery.of(context).size.width,
                height: 200,
                top: Text(
                  "${timeDate[index]}",
                  style: TextStyle(fontSize: 15),
                ),
                middle: Row(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage(profileImages[index]),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(bookingTypes[index])),
                              Text(
                                names[index],
                                style: TextStyle(color: Colors.grey),
                              )
                            ]))
                  ],
                ),
                bottom: Row(
                  children: <Widget>[
                    Spacer(),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black)),
                      child: Center(
                        child: Text("Reschedule"),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black)),
                      child: Center(
                        child: Text("cancel"),
                      ),
                    )
                  ],
                ),
                onTap: () {},
              ));
        },
        itemCount: bookingTypes.length);
  }
}
