import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsTile extends StatefulWidget {
 final  double width;
 final  double height;
 final  Function onTap;
 final  Widget top;
 final  Widget middle;
 final  Widget bottom;

  AppointmentsTile({
    @required this.width,
    @required this.height,
    @required this.onTap,
    this.top,
    this.middle,
    this.bottom,
  });

  _AppointmentsTile createState() => _AppointmentsTile();
}

class _AppointmentsTile extends State<AppointmentsTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: widget.height,
          width: widget.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.top,
              Divider(
                color: Colors.black,
              ),
              widget.middle,
              Spacer(),
              Divider(
                color: Colors.black,
              ),
              widget.bottom
            ],
          ),
        ),
      ),
    );
  }
}
