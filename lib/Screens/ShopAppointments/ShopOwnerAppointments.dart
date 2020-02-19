import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hair_cos/CustomViews/AppointmentsTile.dart';
import 'package:hair_cos/Models/DateConversion.dart';
import 'package:table_calendar/table_calendar.dart';

class ShopOwnerAppointments extends StatefulWidget {
  _ShopOwnerAppointments createState() => _ShopOwnerAppointments();
}

class _ShopOwnerAppointments extends State<ShopOwnerAppointments> {
  String appBarName = "Your Appointments";
  String profileImage = "asserts/barber_pic_3.jpg";
  String name = "Mzimkhulu Ncube";
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _currentEvent;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    _currentEvent = [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
      ),
      body: Column(children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: TableCalendar(
              events: _events,
              calendarController: _calendarController,
              initialCalendarFormat: CalendarFormat.twoWeeks,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                  selectedColor: Theme.of(context).primaryColor,
                  todayColor: Colors.green,
                  todayStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              onDaySelected: (date, events) {
                setState(() {
                  _currentEvent = events;
                });
              },
            )),
        Expanded(flex: 1, child: getEvents())
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_events[_calendarController.selectedDay] != null) {
              _events[_calendarController.selectedDay].add("hello world");
            } else {
              _events[_calendarController.selectedDay] = ["hello world"];
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getEvents() {
    if (_currentEvent.length > 0)
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _currentEvent.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                child: AppointmentsTile(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  top: Text(
                    "${DateConversion.getDayOfMonth(_calendarController.selectedDay.weekday)}, "
                    "${_calendarController.selectedDay.day} "
                    "${DateConversion.getShortMonthName(_calendarController.selectedDay.month)} "
                    "${_calendarController.selectedDay.year} "
                    "| 20 : 00",
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
                                image: AssetImage("asserts/barber_pic_1.jpg"),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Text("Fade cut")),
                                Text(
                                  "Mzimkhulu Ncube",
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
          });
    else
      return Container(
        child: Center(
          child: Column(children: <Widget>[
            Icon(
              Icons.blur_off,
              size: 200,
              color: Colors.grey,
            ),
            Text("No Appointments on this date")
          ]),
        ),
      );
  }
}
