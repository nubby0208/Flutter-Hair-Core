import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Products/payment_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingTime extends StatefulWidget {
  @override
  _BookingTimeState createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Types'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset('assets/images/b1.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Zik',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        child: Image.asset('assets/images/b2.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ken',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        child: Image.asset('assets/images/b3.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Celeb',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              Container(
                child: _buildTableCalendar(),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              Container(
                  height: 60,
                  child: GridView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, childAspectRatio: 2.5),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5, bottom: 5),
                            height: 20,
                            decoration: BoxDecoration(
                              color: selected == index
                                  ? Colors.blue
                                  : Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                index == 0
                                    ? '10:00'
                                    : index == 1
                                        ? '11:00'
                                        : index == 2
                                            ? '12:00'
                                            : index == 3
                                                ? '13:00'
                                                : index == 4
                                                    ? '14:00'
                                                    : index == 5
                                                        ? '15:00'
                                                        : index == 6
                                                            ? '16:00'
                                                            : index == 7
                                                                ? '17:00'
                                                                : index == 8
                                                                    ? '18:00'
                                                                    : '19:00',
                                style: TextStyle(
                                  color: selected == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              ListTile(
                title: Text(
                  'Hair Cut',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '45 mins   |   £ 15',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  size: 40,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton.roundedButton(context,
                  txt: 'Confirm',
                  background: secondaryColor,
                  onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentScreen2())),
                  textColor: Colors.black)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.black, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(width: 1, color: Colors.black)),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }
}
