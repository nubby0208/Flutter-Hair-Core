import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';
import 'package:hair_cos/Models/ShopUser.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class ShopViewDetails extends StatefulWidget {
  @override
  _ShopViewDetailsState createState() => _ShopViewDetailsState();
}

class _ShopViewDetailsState extends State<ShopViewDetails> {
  String sid = "ExampleShopID";
  String shopName = "";
  String shopAddress = "";
  String shopEmail = "";
  String shopContact = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    StateContainer.of(context).database.getShopProfile(
      sid,
      onData: (ShopUser user) {
        shopName = user.name;
        shopAddress = user.address;
        shopEmail = user.email;
        shopContact = user.contact;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Shop Details"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          getProfile(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditDetails(
                      type: "Shop Name",
                      text: shopName,
                      onPress: (txt) {
                        container.database.upLoadShopName(
                          sid: sid,
                          name: txt,
                        );
                      },
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.shop),
            title: Text("Shop Name"),
            subtitle: Text(shopName),
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
                      text: shopAddress,
                      onPress: (txt) {
                        container.database.upLoadShopAddress(
                          sid: sid,
                          address: txt,
                        );
                      },
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.location_on),
            title: Text("Shop Address"),
            subtitle: Text(shopAddress),
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
                      type: "Shop Email",
                      text: shopEmail,
                      inputType: TextInputType.emailAddress,
                      onPress: (txt) {
                        container.database.upLoadShopEmail(
                          sid: sid,
                          email: txt,
                        );
                      },
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.shop),
            title: Text("Shop Email"),
            subtitle: Text(shopEmail),
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
                      type: "Shop Contact",
                      text: shopContact,
                      inputType: TextInputType.phone,
                      onPress: (txt) {
                        container.database.upLoadShopContact(
                          sid: sid,
                          contact: txt,
                        );
                      },
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.shop),
            title: Text("Shop Contact"),
            subtitle: Text(shopContact),
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
