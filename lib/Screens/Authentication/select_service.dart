/* import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/login.dart';
import 'package:hair_cos/Screens/Authentication/signup.dart';

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
              padding: EdgeInsets.only(left: 5, right: 5),
              width: size.width / 2.15,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  image: DecorationImage(
                      image: AssetImage('assets/images/buisness.png'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(''),
                  Text(
                    'Set up as a hairdresser/salon & and start receiving appointments',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        User.userData.buisness=true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => User.userData.login
                                  ? LoginContent()
                                  : SignUpContent(
                                      buissness: true,
                                    )));
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
            Container(
              height: size.height / 1.5,
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(left: 10, right: 10),
              //padding: EdgeInsets.all(20),
              //margin: EdgeInsets.all(10),
              width: size.width / 2.15,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  image: DecorationImage(
                      image: AssetImage('assets/images/non-buisness.png'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(''),
                  Text(
                    'Set up as an independent barber/ hairdresser & receiving appointments',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        User.userData.buisness = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => User.userData.login
                                  ? LoginContent()
                                  : SignUpContent(
                                      buissness: false,
                                    )));
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
            )
          ],
        ),
      ),
    );
  }
}
 */