import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Screens/search/shop_details.dart';

class SaloonCatagories extends StatefulWidget {
  @override
  _SaloonCatagoriesState createState() => _SaloonCatagoriesState();
}

class _SaloonCatagoriesState extends State<SaloonCatagories> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 9,
                padding: EdgeInsets.only(left: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Text(
                        index == 0
                            ? 'All'
                            : index == 1
                                ? 'Barber Shop'
                                : index == 2
                                    ? 'Hair Saloon'
                                    : index == 3 ? 'Make up' : 'Make up',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                selected == index ? FontWeight.bold : null,
                            color: selected == index ? Colors.red : null),
                      ),
                    ),
                  );
                },
              ),
            ),
            preferredSize: Size.fromHeight(40)),
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                hintText: 'Seacrh'),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Results 1548',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Sort',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        'assets/images/sort.png',
                        scale: 5,
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => imageCard(index)),
            )
          ],
        ),
      ),
    );
  }

  imageCard(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopDetails()));
      },
      child: Card(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.width / 1.8,
            padding: EdgeInsets.only(right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/images/shopName.png',
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
                              'Baber Shop United',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '17  Broomfield Place, STON EASTON,BA3 6WD',
                              style: TextStyle(
                                fontSize: 13,
                              ),
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
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 10,
                  ),
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: secondaryColor)),
                        child: Image.asset('assets/images/hair1.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: secondaryColor)),
                        child: Image.asset('assets/images/hair2.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: secondaryColor)),
                        child: Image.asset('assets/images/hair3.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: secondaryColor)),
                        child: Image.asset('assets/images/hair4.png'),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
