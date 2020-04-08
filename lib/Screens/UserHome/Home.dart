import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/app_bar.dart';
import 'package:hair_cos/Screens/drawer.dart';
import 'package:hair_cos/autoAddress.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var serviceType = [];
  String pic = "asserts/shop_picture.jpg";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
            backgroundColor: secondaryColor,
            child: Icon(
              Icons.location_on,
              size: 35,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AutoAddress()))),
        appBar: PreferredSize(
            child: CustomAppBar(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
            ),
            preferredSize: Size.fromHeight(60)),
        drawer: DrawerFull(context, size),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Recommend Services',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => imageCard(index)),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'View All',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              Text(
                'Products Reccomended for you',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) => imageCard2(index)),
              ),
            ],
          ),
        ));
  }

  imageCard(int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.width / 4.2,
            padding: EdgeInsets.only(right: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Image.asset(
                      index == 0
                          ? 'assets/images/1.png'
                          : 'assets/images/2.png',
                      fit: BoxFit.fitHeight,
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: null,
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                  color: secondaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }

  imageCard2(int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.width / 4.2,
            padding: EdgeInsets.only(right: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/scissor.png',
                      fit: BoxFit.fitHeight,
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Y.S. Park YS-254 Bar',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '\$ 966',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '\$1096',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              '9% OFF',
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                            Text(''),
                            Text(''),
                            Text(''),
                            Text(''),
                          ],
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
