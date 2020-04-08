import 'package:flutter/material.dart';

class CustomDrop extends StatefulWidget {
  final List<String> list;
  final String selected;
  CustomDrop({@required this.list, @required this.selected});
  @override
  _CustomDropState createState() => _CustomDropState();
}

class _CustomDropState extends State<CustomDrop> {
  String selected;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(left: 30, right: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 45,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            iconSize: 40,
            value: selected,
            items: widget.list.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(
                  value,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selected = val;
              });
            },
          ),
        ),
      ),
    );
  }
}
