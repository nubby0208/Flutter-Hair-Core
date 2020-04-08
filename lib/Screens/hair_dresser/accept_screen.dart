import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';

class AcceptScreen extends StatefulWidget {
  @override
  _AcceptScreenState createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  bool smile = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Text(''),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Inertia',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy')),
            TextSpan(
                text: ' Cosmetics',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    color: Colors.black))
          ])),
        ),
        body: smile ? _smile() : box());
  }

  Widget _smile() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/smile.png',
            scale: 5,
          ),
          Text(
            'Enjoy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Text(
            'We take 5% to cover the processing fees, that means we take x amount and you have x',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          CustomButton.roundedButton(context,
              txt: 'Continue',
              textColor: Colors.black,
              background: secondaryColor, onPress: () {
            setState(() {
              smile = false;
            });
          }),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
        ],
      ),
    );
  }

  box() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/mail.png',
            scale: 5,
          ),
          Text(
            'We will notify you when user accepts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            textAlign: TextAlign.center,
          ),
          CustomButton.roundedButton(context,
              txt: 'Continue',
              textColor: Colors.black,
              background: secondaryColor,
              onPress: null),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
        ],
      ),
    );
  }
}
