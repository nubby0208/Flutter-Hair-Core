import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/Products/payment_screen.dart';
import 'package:hair_cos/Screens/search/shop_booking_types.dart';

class ShopDetails extends StatefulWidget {
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: size.width,
                  height: size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/shopCover.png'),
                          fit: BoxFit.fitWidth)),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height / 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            Text(
                              "People's Barber",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(''),
                            Text(''),
                          ],
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/shopDp.png'),
                        )
                      ],
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'About us',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    padd(10.0),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                    padd(10.0),
                    Text(
                      'Members',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/b1.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/b2.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/b3.png'),
                        )
                      ],
                    ),
                    padd(10.0),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                    Text(
                      'Gallery ',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(index == 0
                                    ? 'assets/images/style1.png'
                                    : index == 1
                                        ? 'assets/images/style2.png'
                                        : index == 2
                                            ? 'assets/images/style3.png'
                                            : 'assets/images/style4.png'));
                          }),
                    ),
                    padd(10.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'View all',
                        style: TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    padd(10.0),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                    Text(
                      'Comments ',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/b2.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Zik Anderson ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_half,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Text(' 4.9'),
                                Text(
                                  ' (148 ratings)',
                                  style: TextStyle(color: Colors.grey[400]),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    padd(10.0),
                    Text(
                      'Pri quas audiam virtute ut, case utamur fuisset eam ut, iisque accommodare an eam//',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/b2.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Zik Anderson ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_half,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Text(' 4.9'),
                                Text(
                                  ' (148 ratings)',
                                  style: TextStyle(color: Colors.grey[400]),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    padd(10.0),
                    Text(
                      'Pri quas audiam virtute ut, case utamur fuisset eam ut, iisque accommodare an eam//',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/b2.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Zik Anderson ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_half,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Text(' 4.9'),
                                Text(
                                  ' (148 ratings)',
                                  style: TextStyle(color: Colors.grey[400]),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    padd(10.0),
                    Text(
                      'Pri quas audiam virtute ut, case utamur fuisset eam ut, iisque accommodare an eam//',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    padd(10.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'View all',
                        style: TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    padd(10.0),
                    Divider(
                      thickness: 2,
                    ),
                    padd(10.0),
                    Text(
                      'Open Times ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(''),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Monday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Tuesday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Wednesday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Thursday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Friday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Saturday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Sunday',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(''),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '09:15 Am - 05:15 Pm',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '09:15 Am - 05:15 Pm',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '09:15 Am - 05:15 Pm',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '09:15 Am - 05:15 Pm',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '09:15 Am - 05:15 Pm',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '10:15 Am - 05:15 Pm',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Closed',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(''),
                      ],
                    ),
                    padd(10.0),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                    padd(10.0),
                    Text(
                      'Contact Us ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.mail,
                          color: secondaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'jogndoe@gmail.om',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: secondaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '07774564654',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    padd(10.0),
                    Text(
                      'Shop Name ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.view_compact,
                          color: secondaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Peoples Barber',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      'Shop Address ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padd(10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: secondaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '11 Billy Gardens NG3 2GU',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    padd(50.0),
                    CustomButton.roundedButton(context,
                        txt: 'Book',
                        background: secondaryColor,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopBookingTypes())),
                        textColor: Colors.black)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  padd(size) {
    return SizedBox(
      height: size,
    );
  }
}
