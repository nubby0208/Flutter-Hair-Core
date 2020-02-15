import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/ShopImages/ShopOwnerImages.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopBookingTypes.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopViewDetails.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopWorkingHours.dart';
import 'package:hair_cos/Services/Images.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import 'package:provider/provider.dart';
import 'ShopMembers.dart';

class ShopOwnerShop extends StatefulWidget {
  _ShopOwnerShop createState() => _ShopOwnerShop();
}

class _ShopOwnerShop extends State<ShopOwnerShop> {
  String name = "People's Barbers";

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return  Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: ShopOwnerShopContent(),
      );
  }
  
  
}

class ShopOwnerShopContent extends StatefulWidget {
  @override
  _ShopOwnerShopContentState createState() => _ShopOwnerShopContentState();
}

class _ShopOwnerShopContentState extends State<ShopOwnerShopContent> {
  String name = "fff";
  String profile = "";
  @override
  Widget build(BuildContext context) {
    return content(context);
  }

  Widget content(context){
    final shopData = Provider.of<DocumentSnapshot>(context);
    try {
      name = shopData.data["ShopName"] ?? "No Name";
    }catch(e){
      name = "No Name";
    }
    profile = shopData.data["ProfileUrl"];
    return ListView(
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
          title: Text("Members"),
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
          title: Text("Working hours"),
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
          title: Text("Booking Types"),
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(Icons.book),
        ),
        paddedDivider(),
        ListTile(
          title: Text("Images"),
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
                image: ImageServices.getNetworkImage(profile),
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

