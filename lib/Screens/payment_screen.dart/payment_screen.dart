import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Models/payment_model.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 25,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            upperContainer(size),
            Text(
              '${Payment.paymentData.text}',
              textAlign: TextAlign.center,
            ),
            paymentCard(size),
            Row(
              children: <Widget>[
                Checkbox(value: rememberMe, onChanged: _onRememberMeChanged),
                Text('This card will be saved for faster payment.')
              ],
            ),
            CustomButton.roundedButton(context,
                textColor: Colors.black, txt: 'Pay', background: secondaryColor)
          ],
        ),
      ),
    );
  }

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

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
      });

  Widget upperContainer(size) {
    return Container(
      padding: EdgeInsets.all(5),
      height: size.width / 4,
      decoration: BoxDecoration(
          color: Color(0xffFDF3BD).withOpacity(.6),
          borderRadius: BorderRadius.circular(60),
          border: Border.all(width: 6, color: secondaryColor)),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: secondaryColor,
            child: Text(
              '30\nDays',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${Payment.paymentData.package}',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '£ ${Payment.paymentData.price}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: size.width / 6,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            child: Icon(
              Icons.check,
              color: Colors.black,
              size: 55,
            ),
          )
        ],
      ),
    );
  }
}
