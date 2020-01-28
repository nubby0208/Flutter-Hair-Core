import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/DateConversion.dart';

class HorizontalCalendar extends StatefulWidget {
  Function onDatePress;
  double width;
  HorizontalCalendar({this.onDatePress, @required this.width});

  _HorizontalCalendar createState() => _HorizontalCalendar();
}

class _HorizontalCalendar extends State<HorizontalCalendar> {
  double width;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    now = now = DateTime.utc(now.year, now.month, now.day);
    while (now.weekday != 1) {
      now = now = DateTime.utc(now.year, now.month, now.day - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    width = widget.width / 7;
    return Column(
      children: <Widget>[
        topCalendar(),
      ],
    );
  }

  Widget topCalendar() {
    return Container(
        child: Column(children: <Widget>[
      Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                now = DateTime.utc(now.year, now.month, now.day - 14);
                widget.onDatePress(now);
              });
            },
            icon: Icon(Icons.arrow_back),
          ),
          Spacer(),
          Text("${DateConversion.getMonthName(now.month)} "
              "${now.year}"),
          Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                now = DateTime.utc(now.year, now.month, now.day);
                widget.onDatePress(now);
              });
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      Divider(
        color: Colors.black,
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                DateTime temp = DateTime(now.year, now.month, now.day);
                now = DateTime.utc(now.year, now.month, now.day + 1);
                DateTime tempNow = DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day);
                return Column(children: <Widget>[
                  InkWell(
                      onTap: () {},
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: temp.difference(tempNow).inDays == 0
                                    ? Colors.red
                                    : Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(20)),),
                        child: Column(children: <Widget>[
                          Text(
                            "${DateConversion.getDayOfMonth(temp.weekday)}",
                            style: TextStyle(
                                color: Colors.black),
                          ),
                          Text("${temp.day}",
                              style: TextStyle(
                                  color: Colors.black))
                        ]),
                      ))
                ]);
              })),
      Divider(
        color: Colors.black,
      )
    ]));
  }

  void addWeek() {
    setState(() {
      now = DateTime.utc(now.year, now.month, now.day + 7);
    });
  }
}
