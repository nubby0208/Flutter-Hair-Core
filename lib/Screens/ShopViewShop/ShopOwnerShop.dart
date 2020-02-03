import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';
import 'package:hair_cos/Screens/ShopImages/ShopOwnerImages.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopBookingTypes.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopViewDetails.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopWorkingHours.dart';
import 'ShopMembers.dart';

class ShopOwnerShop extends StatefulWidget {
  _ShopOwnerShop createState() => _ShopOwnerShop();
}

class _ShopOwnerShop extends State<ShopOwnerShop> {
  String name = "People's Barbers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10), child: getProfile()),
          ),
          fullDivider(),
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
            leading: Icon(Icons.supervisor_account),
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
            title: Text("Shop working hours"),
            trailing: Icon(Icons.keyboard_arrow_right),
            leading: Icon(Icons.access_time),
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
            title: Text("Shop Booking Types"),
            trailing: Icon(Icons.keyboard_arrow_right),
            leading: Icon(Icons.book),
          ),
          paddedDivider(),
          ListTile(
            title: Text("Shop Images"),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ShopOwnerImages();
                  },
                ),
              );
            },
            leading: Icon(Icons.image),
          ),
        ],
      ),
    );
  }

  Widget paddedDivider() {
    return Divider(
      color: Colors.black,
      indent: 70,
    );
  }

  Widget fullDivider() {
    return Divider(color: Colors.black);
  }

  Widget getProfile() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage("asserts/food.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ShopViewDetails();
                    },
                  ),
                );
              },
              child: Text(
                "Edit Shop Details",
                style: TextStyle(fontSize: 15, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}
