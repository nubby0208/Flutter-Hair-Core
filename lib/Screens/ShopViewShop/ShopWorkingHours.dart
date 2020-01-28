import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/ShopViewShop/WorkingHours.dart';

class ShopWorkingHours extends StatefulWidget {
  @override
  _ShopWorkingHoursState createState() => _ShopWorkingHoursState();
}

class _ShopWorkingHoursState extends State<ShopWorkingHours> {
  Map<String, WorkingHours> openTime = {};
  var daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 7; i++) {
      openTime[daysOfWeek[i]] = WorkingHours(
        day: daysOfWeek[i],
        openTime: "00 : 00",
        closeTime: "00 : 00",
        open: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Working Hours"),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {},
                  title: Text("${openTime[daysOfWeek[index]].day} "),
                  subtitle: Text(
                    "${openTime[daysOfWeek[index]].openTime}"
                    " - ${openTime[daysOfWeek[index]].closeTime}",
                  ),
                  trailing: Text(
                    "${openTime[daysOfWeek[index]].open ? "Open" : "Closed"}",
                    style: TextStyle(
                      color: openTime[daysOfWeek[index]].open
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: openTime.length,
        ));
  }
}
