import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsTile extends StatefulWidget {
  double width;
  double height;
  Function onTap;
  Widget top;
  Widget middle;
  Widget bottom;

  AppointmentsTile(
      {@required this.width,
      @required this.height,
      @required this.onTap,
      this.top,
      this.middle,
      this.bottom});

  _AppointmentsTile createState() => _AppointmentsTile();
}

class _AppointmentsTile extends State<AppointmentsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey[300]),
          boxShadow: [
            new BoxShadow(
                color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 5)
          ],
        ),
        child: InkWell(
            onTap: () {
              widget.onTap();
            },
            child: Padding(
                padding: EdgeInsets.all(10),
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
                ))));
  }
}
