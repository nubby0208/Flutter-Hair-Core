import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Models/payment_model.dart';
import 'package:hair_cos/Screens/payment_screen.dart/payment_screen.dart';

class PaymentPlan extends StatefulWidget {
  @override
  _PaymentPlanState createState() => _PaymentPlanState();
}

class _PaymentPlanState extends State<PaymentPlan> {
  String p1 = 'Basic', p2 = 'Premium', p3 = 'Royalty';
  String def =
      '+ VAT , basic features, able to receive bookings with 10 mile radius ,chat to customers';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          'assets/images/menu.png',
          scale: 8,
        ),
        title: Text('Choose your plan'),
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
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              'Your free trial has expired',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Your are no longer on a free trial. Select the best plan for your business. Help your business grow with 24/7 availability. ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buisness(size),
            SizedBox(
              height: 10,
            ),
            Text(
              'Need more help? We are always here for you ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(''),
                  Text(''),
                  CustomButton.roundedButton(context,
                      borderColor: secondaryColor,
                      background: Colors.white,
                      txt: 'Contact us',
                      textColor: secondaryColor),
                  CustomButton.roundedButton(context,
                      borderColor: secondaryColor,
                      background: Colors.white,
                      txt: 'Contact us',
                      textColor: secondaryColor),
                  Text(''),
                  Text(''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /* Widget nonBuisness(size) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: size.width / 3,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    height: double.infinity,
                    width: 2,
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Basic'),
                                Text(
                                  '£ 13.99',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Payment.paymentData.package = 'Basic';
                                  Payment.paymentData.price = '13.99';
                                  Payment.paymentData.text =
                                      '13.99 + VAT , basic features, able to receive bookings with 10 mile radius ,chat to customers ';
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentScreen()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor,
                                ),
                                child: Text(
                                  'Subscribe',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '13.99 + VAT , basic features, able to receive bookings with 10 mile radius ,chat to customers ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: size.width / 3,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    height: double.infinity,
                    width: 2,
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Premium'),
                                Text(
                                  '£ 25.99',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Payment.paymentData.package = 'Premium';
                                  Payment.paymentData.price = '25.99';
                                  Payment.paymentData.text =
                                      '25.99 + VAT , basic features, able to receive bookings with 10 mile radius ,chat to customers ';
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentScreen()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor,
                                ),
                                child: Text(
                                  'Subscribe',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '25.99 + VAT , basic features, able to receive bookings with 10 mile radius ,chat to customers ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
 */
  Widget buisness(size) {
    return Expanded(
      flex: 5,
      //height: size.height / 2,
      child: ListView(
        children: <Widget>[
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: size.width / 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      height: double.infinity,
                      width: 2,
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Basic'),
                                  Text(
                                    '£ 15.99',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Payment.paymentData.package = 'Basic';
                                    Payment.paymentData.price = '15.99';
                                    Payment.paymentData.text =
                                        'For basic £15.99 + VAT : simple booking system,add multiple barbers, appointment handling, allows customers to book you straight away.';
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor,
                                  ),
                                  child: Text(
                                    'Subscribe',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'For basic £15.99 + VAT : simple booking system,add multiple barbers, appointment handling, allows customers to book you straight away.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: size.width / 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      height: double.infinity,
                      width: 2,
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Basic'),
                                  Text(
                                    '£ 25.99',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Payment.paymentData.package = 'Premium';
                                    Payment.paymentData.price = '25.99';
                                    Payment.paymentData.text =
                                        '25.99: premium :basic features + in app chat system for efficient and direct communication with customers , feature to post vacancies and look for barbers';
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor,
                                  ),
                                  child: Text(
                                    'Subscribe',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '25.99: premium :basic features + in app chat system for efficient and direct communication with customers , feature to post vacancies and look for barbers ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: size.width / 2.8,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff41A8FD),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      height: double.infinity,
                      width: 2,
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Royalty'),
                                  Text(
                                    '£ 39.99',
                                    style: TextStyle(
                                        color: Color(0xff41A8FD),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Payment.paymentData.package = 'Royalty';
                                    Payment.paymentData.price = '39.99';
                                    Payment.paymentData.text =
                                        '39.99 Royalty ,includes premium features but allows you to sell your own products (very good if you have repeat customers). 5% discount on all your barbers/hairdressers sign up fee if they choose to be a mobile hairdresser at any time';
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor,
                                  ),
                                  child: Text(
                                    'Subscribe',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '39.99 Royalty ,includes premium features but allows you to sell your own products (very good if you have repeat customers). 5% discount on all your barbers/hairdressers sign up fee if they choose to be a mobile hairdresser at any time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
