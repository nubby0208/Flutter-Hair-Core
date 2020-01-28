import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopBookingTypes.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopWorkingHours.dart';

import 'ShopMembers.dart';

class ShopOwnerShop extends StatefulWidget {
  _ShopOwnerShop createState() => _ShopOwnerShop();
}

class _ShopOwnerShop extends State<ShopOwnerShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Shop"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10), child: getProfile()),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditDetails(
                      type: "Shop Name",
                      text: "People's Barber",
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.shop),
            title: Text("Shop Name"),
            subtitle: Text("People's Barber"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditDetails(
                      type: "Shop Address",
                      text: "11 Bilby Gardens NG3 2GU",
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.location_on),
            title: Text("Shop Address"),
            subtitle: Text("11 Bilby Gardens NG3 2GU"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
              child: Text(
                "Other Options",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              )),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShopMembers();
                  },
                ),
              );
            },
            title: Text("Shop Members"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShopWorkingHours();
                  },
                ),
              );
            },
            title: Text("Your working hours"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          paddedDivider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShopBookingTypes();
                  },
                ),
              );
            },
            title: Text("Your Booking Types"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }

  Widget paddedDivider() {
    return Divider(
      color: Colors.black,
      indent: 20,
    );
  }

  Widget fullDivider() {
    return Divider(color: Colors.black);
  }

  Widget getProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: AssetImage("asserts/food.jpg"), fit: BoxFit.fill),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              color: Colors.blue,
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
