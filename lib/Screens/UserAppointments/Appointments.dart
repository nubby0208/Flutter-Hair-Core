/* import 'package:flutter/cupertino.dart';
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
 */

import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Messages/messages.dart';
import 'package:hair_cos/Screens/payment_screen.dart/payment_plan.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Appointments"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return imageCard2(index);
                    }),
              )
            ],
          ),
        ));
  }

  imageCard2(int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.width / 1.6,
            padding: EdgeInsets.only(right: 5, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 100,
                          child: Image.asset(
                            index == 0
                                ? 'assets/images/apt1.png'
                                : 'assets/images/apt2.png',
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Tue, 18 Mar at 4:30 Pm ',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            Text(
                              'Beard Trim',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            Text(
                              'Russell Robins ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              maxLines: 1,
                            ),
                            Container(
                              height: 30,
                              width: 100,
                              child: CustomButton.roundedButton(context,
                                  onPress: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Messages(
                                              currentUserId:
                                                  User.userData.userId))),
                                  txt: 'Chat',
                                  bold: false,
                                  fontsize: 13.0,
                                  textColor: Colors.white,
                                  background: Colors.green),
                            )
                          ],
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                      'Pri quas audiam virtute ut, case utamur fuisset eam ut, iisque accommodare an eam. Reque blandit qui eu, cu vix nonumy volumus. Legendos intellegam id usu, vide oporteat vix eu, id illud principes has. Nam tempor utamur gubergren no.'),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 10, right: 5),
                      height: 40,
                      child: CustomButton.roundedButton(context,
                          txt: 'Reschedule',
                          background: secondaryColor,
                          onPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentPlan())),
                          fontsize: 15.0,
                          textColor: Colors.black),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 10, right: 5),
                      height: 40,
                      child: CustomButton.roundedButton(context,
                          txt: 'Cancel',
                          background: Colors.red,
                          fontsize: 15.0,
                          textColor: Colors.black),
                    ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
