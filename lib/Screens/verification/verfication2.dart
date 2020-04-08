import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Screens/payment_screen.dart/payment_plan.dart';

class Verification2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/images/cloud.png',
              scale: 5,
            ),
            Text(
              'To verify your business we need to see your business tax document.Then you can enjoy using our services',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              textAlign: TextAlign.center,
            ),
            Text(
              'After this step you will be able to use our services  ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            CustomButton.roundedButton(context,
                textColor: Colors.black,
                txt: 'Continue',
                background: secondaryColor,
                onPress: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentPlan()))),
            Text(
              'if you click continue an email will be sent so you can continue with the process',
              textAlign: TextAlign.center,
            ),
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
