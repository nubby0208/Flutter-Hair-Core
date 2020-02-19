import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/ShopSignUp/ShopServices.dart';
import 'package:hair_cos/Screens/UserHome/ShopSearch.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  var serviceType = [];
  String pic = "asserts/shop_picture.jpg";

  @override
  void initState() {
    super.initState();
    serviceType = ServicesTypes.serviceType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hair Cos"),
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return cards(
            pic: pic,
            name: serviceType[index],
            onData: () {},
          );
        },
        itemCount: serviceType.length,
      ),
    );
  }

  Widget cards({String pic, String name, Function onData}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ShopSearch(searchType: name,);
        }));
      },
      child: Card(
        elevation: 5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(pic),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
