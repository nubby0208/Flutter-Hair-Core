import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Screens/search/booking_saloon.dart';
import 'package:hair_cos/Screens/search/saloon_catagories.dart';
import 'package:hair_cos/Screens/search/shop_home_servies.dart';

class SelectService extends StatefulWidget {
  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Services'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              height: size.height / 1.5,
              width: size.width / 2.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/goShop.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.only(left: 5, right: 5),
                color: Colors.black.withOpacity(.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Book appointment at salon\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaloonCatagories()));
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: secondaryColor,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height / 1.5,
              margin: EdgeInsets.only(left: 5),
              //padding: EdgeInsets.all(20),
              //margin: EdgeInsets.all(10),
              width: size.width / 2.15,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/home.png'),
                      fit: BoxFit.cover)),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                color: Colors.black.withOpacity(.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Hire a mobile hairdresser to your door',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookSalon(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: secondaryColor,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
