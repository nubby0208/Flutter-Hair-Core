import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/drop_down.dart';

class HairDresserSettings extends StatefulWidget {
  @override
  _HairDresserSettingsState createState() => _HairDresserSettingsState();
}

class _HairDresserSettingsState extends State<HairDresserSettings> {
  List<String> list1 = ['2 miles', '3 miles', '4 miles', '5 miles'];
  List<String> services = ['Hair Cuts', 'Beard', 'Facial mask'];
  List<String> services2 = ['Bald Shaves', 'trimming', 'Waxing'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Settings'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Travel Radius',
              style: TextStyle(fontSize: 19),
            ),
            CustomDrop(list: list1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Services',
                  style: TextStyle(fontSize: 19),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                  ),
                  child: Center(
                      child: Icon(Icons.add, size: 15, color: Colors.white)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomDrop(
                  list: services,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: Center(
                      child: Icon(Icons.clear, size: 15, color: Colors.white)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomDrop(
                  list: services2,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: Center(
                      child: Icon(Icons.clear, size: 15, color: Colors.white)),
                )
              ],
            ),
            CustomButton.roundedButton(context,
                txt: 'Save',
                background: secondaryColor,
                textColor: Colors.black),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
          ],
        ),
      ),
    );
  }
}
