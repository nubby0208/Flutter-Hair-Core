import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NamedTittle extends StatefulWidget {
  String title;
  String subTitle;

  NamedTittle({@required this.title, @required this.subTitle});

  _NamedTittle createState() => _NamedTittle();
}

class _NamedTittle extends State<NamedTittle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title + " :", style: TextStyle(color: Colors.grey),),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
          child: Text(widget.subTitle, style: TextStyle(fontSize: 20),),
        ),
        Divider(color: Colors.black,)
      ],
    );
  }
}
