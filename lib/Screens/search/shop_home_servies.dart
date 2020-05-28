import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/drop_down.dart';
import 'package:hair_cos/Products/payment_screen.dart';

class BarberShop extends StatefulWidget {
  final Map type;
  BarberShop({this.type});
  @override
  _BarberShopState createState() => _BarberShopState();
}

class _BarberShopState extends State<BarberShop> {
  List<String> services2 = ['Bald Shaves', 'trimming', 'Waxing'];
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Hair Dresser'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cutting.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                            ),
                            color: Colors.black.withOpacity(.5)),
                        child: Center(
                          child: Text(
                            '£15.99',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              padd(10.0),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*  Text(
                      'Freshen up your look with a new one',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    padd(10.0),
                    Text(
                      'Barber shop United ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black38,
                      ),
                      maxLines: 2,
                    ),
                    padd(10.0),
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
                    padd(10.0),
                     */
                    Text(
                      'Hair Style Type',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    padd(10.0),
                    CustomDrop(
                      list: services2,
                      selected: services2.first,
                    ),
                    padd(10.0),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                          height: 45,
                          width: double.infinity,
                          // padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 30),
                            title: Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(Icons.calendar_today),
                            onTap: null,
                          )),
                    ),
                    padd(10.0),
                    Text(
                      'Please upload 1 to 3 pictures of the type style you desire. ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    padd(10.0),
                    Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.add,
                                size: 80,
                                color: Colors.white,
                              ),
                            );
                          }),
                    ),
                    padd(10.0),
                    Text(
                      'Please describe in as much detail what type of styling you would like.',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    padd(10.0),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Pri quas audiam virtute ut, case utamur fuisset eam ut, iisque accommodare an eam. Reque blandit qui eu, cu vix nonumy volumus. Legendos intellegam id usu, vide oporteat vix eu, id illud principes has. Nam tempor utamur gubergren no.',
                          style: TextStyle(height: 1.4),
                        ),
                      ),
                    ),
                    padd(10.0),
                    Text(
                      'Then below say do you want to buy our hair mat (stops hair going on your carpet)',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    padd(10.0),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/spider.png',
                            scale: 4,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Barber Mat Non-slip Design',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '\n'),
                              TextSpan(
                                text: '\$ 99',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check1 ? check1 = false : check1 = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: secondaryColor,
                              child: check1
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ),
                    padd(10.0),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/comb.png',
                            scale: 4,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Barber Mat Non-slip Design',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '\n'),
                              TextSpan(
                                text: '\$ 99',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check2 ? check2 = false : check2 = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: secondaryColor,
                              child: check2
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ),
                    padd(10.0),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/brush.png',
                            scale: 4,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Barber Mat Non-slip Design',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '\n'),
                              TextSpan(
                                text: '\$ 99',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check3 ? check3 = false : check3 = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: secondaryColor,
                              child: check3
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ),
                    padd(10.0),
                    CustomButton.roundedButton(context,
                        txt: 'Palce Order',
                        background: secondaryColor,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen2())),
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
