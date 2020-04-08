import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function onTap;
  CustomAppBar({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          'assets/images/menu.png',
          scale: 8,
        ),
      ),
      title: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'Hair',
            style: TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy')),
        TextSpan(
            text: 'Cos',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy',
                color: Colors.black))
      ])),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(5.0, 10.0, 10, 0),
                child: InkWell(
                  onTap: null,
                  child: Image.asset(
                    'assets/images/cart.png',
                    scale: 7,
                  ),
                )),
            Positioned(
                left: 20,
                top: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 10),
                  ),
                  radius: 7,
                )),
          ],
        ),
      ],
    );
  }
}
