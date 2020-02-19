import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';
import 'package:hair_cos/Services/Images.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import 'package:provider/provider.dart';

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
  String shopProfile = "";
  String shopAbout = "";
  var container;
  var shopData;

  @override
  Widget build(BuildContext context) {
    container = StateContainer.of(context);
    shopData = Provider.of<DocumentSnapshot>(context);
    getAttributes();
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
            leading: Icon(Icons.email),
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
            leading: Icon(Icons.phone),
            title: Text("Shop Contact"),
            subtitle: Text(shopContact),
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
                      type: "Shop About",
                      text: shopAbout,
                      onPress: (txt) {
                        container.database.upLoadShopAbout(
                          sid: sid,
                          text: txt,
                        );
                      },
                    );
                  },
                ),
              );
            },
            leading: Icon(Icons.info),
            title: Text("About"),
            subtitle: Text("$shopAbout"),
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
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              image: DecorationImage(
                image: ImageServices.getNetworkImage(shopProfile),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              color: Colors.blue,
              onPressed: () async {
                File file = await ImageServices.getImageFromCamera();
                container.database.upLoadShopImage(
                  sid: sid,
                  image: file,
                  onData: (profileUrl) {
                    setState(() {
                      this.shopProfile = profileUrl;
                    });
                  },
                  prevUrl: shopProfile,
                );
              },
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

  void getAttributes() {
    sid = shopData.documentID;
    shopName = shopData.data["ShopName"] ?? "No name";
    shopAddress = shopData.data["Address"] ?? "No address";
    shopEmail = shopData.data["Email"] ?? "No email";
    shopContact = shopData.data["Contact"] ?? "No contact";
    shopProfile = shopData.data["ProfileUrl"];
    shopAbout = shopData.data["About"] ?? "No About";
  }
}
