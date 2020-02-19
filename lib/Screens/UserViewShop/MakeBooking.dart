import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MakeBooking extends StatefulWidget {
 final String bookingInfo;

  MakeBooking({@required this.bookingInfo});

  _MakeBooking createState() => _MakeBooking();
}

class _MakeBooking extends State<MakeBooking> {
  final profileImages = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg",
  ];
  final names = ['Zic', 'Ken', 'Caleb'];
  int currentMember = 0;
  int selectedTime = 0;
  CalendarController _calendarController;
  List<Widget> availableTimes;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    loadTimes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm details"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            members(),
            fullDivider(),
            calendar(),
            fullDivider(),
            Wrap(
              children: availableTimes,
            ),
            fullDivider(),
            bookingType(),
            fullDivider(),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.blue,
              child: Container(
                  height: 50,
                  child: Center(
                      child: Text("CONFIRM",
                          style: TextStyle(color: Colors.white)))),
            ),
          ],
        ),
      ),
    );
  }

  Widget calendar() {
    return TableCalendar(
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.monday,
      initialCalendarFormat: CalendarFormat.twoWeeks,
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Colors.green,
        todayStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget members() {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: profileImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      currentMember = index;
                    });
                  },
                  child: Container(
                    width: currentMember == index ? 60 : 30,
                    height: currentMember == index ? 60 : 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: currentMember == index
                              ? Colors.blue
                              : Colors.black,
                          width: currentMember == index ? 2 : 0),
                      image: DecorationImage(
                          image: AssetImage(profileImages[index]),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Text(names[index]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bookingType() {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        child: ListTile(
          onTap: () {},
          leading: Icon(Icons.library_books),
          title: Text(widget.bookingInfo),
          subtitle: Text("45 mins | £15"),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_right),
          ),
        ));
  }

  Widget fullDivider() {
    return Divider(
      color: Colors.black,
    );
  }

  Widget halfDivider() {
    return Divider(
      color: Colors.black,
      indent: 50,
      endIndent: 50,
    );
  }

  void loadTimes() {
    availableTimes = [];
    for (int i = 0; i < 10; i++) {
      availableTimes.add(Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            onPressed: () {
              setState(() {
                selectedTime = i;
              });
            },
            color: i == selectedTime ? Colors.blue : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black)),
            child: Text(
              "${i + 10}:00",
              style: TextStyle(
                  color: i == selectedTime ? Colors.white : Colors.black),
            ),
          )));
    }
  }
}
