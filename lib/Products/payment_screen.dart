import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';

class PaymentScreen2 extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen2> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            paymentCard(size),
            Row(
              children: <Widget>[
                Checkbox(
                    value: rememberMe,
                    activeColor: Colors.blueGrey,
                    checkColor: Colors.blueAccent,
                    onChanged: _onRememberMeChanged),
                Text(
                  'This Card will be saved for faster payments',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CustomButton.roundedButton(context,
                txt: 'Pay',
                background: secondaryColor,
                onPress: () =>
                    showDialog(context: context, builder: (_) => showDial()),
                textColor: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget showDial() {
    return Dialog(
      elevation: 0,
      child: Container(
          height: MediaQuery.of(context).size.width / 1.35,
          width: 300,
          padding: EdgeInsets.all(10),
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/images/thankyou.png',
                scale: 5,
              ),
              Text(
                'Your order has been placed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "We will notify you once we've found a hairdresser/barber that can satisfy your order",
                textAlign: TextAlign.center,
              ),
              Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: null,
                child: Container(child: Text('Ok')),
              ),
            ],
          )),
    );
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
      });

  Widget paymentCard(size) {
    return Card(
      color: Color(0xffF4F8F9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        height: size.width / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Enter Card Number'),
            Container(
              height: 50,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.grey[300])),
              child: TextFormField(
                controller: null,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    border: InputBorder.none,
                    hintText: 'Enter Card Number',
                    helperStyle: TextStyle(color: Colors.grey[300]),
                    suffixIcon:
                        Icon(Icons.credit_card, color: Colors.grey[300])),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Expire / Validity Date'),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 1, color: Colors.grey[300])),
                        child: TextFormField(
                          controller: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              border: InputBorder.none,
                              hintText: 'MM / YY',
                              helperStyle: TextStyle(color: Colors.grey[300]),
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: Colors.grey[300])),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Security Code'),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 1, color: Colors.grey[300])),
                        child: TextFormField(
                          controller: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              border: InputBorder.none,
                              hintText: 'Enter Security Code',
                              helperStyle: TextStyle(color: Colors.grey[300]),
                              suffixIcon: Icon(Icons.security,
                                  color: Colors.grey[300])),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Help?',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
