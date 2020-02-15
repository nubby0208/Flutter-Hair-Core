import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/Authentication/main.dart';
import 'package:hair_cos/Screens/UserProfile/EditProfile.dart';
import 'package:hair_cos/Screens/ShopAppointments/ShopOwnerAppointments.dart';
import 'package:hair_cos/Screens/ShopImages/ShopOwnerImages.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopOwnerShop.dart';
import 'package:hair_cos/Services/Images.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class ShopOwnerProfile extends StatefulWidget {
  ShopOwnerProfile();

  _ShopOwnerProfile createState() => _ShopOwnerProfile();
}

class _ShopOwnerProfile extends State<ShopOwnerProfile> {
  String profileImage = "";
  String name;

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    name = container.database.user.isNameEmpty()
        ? "No name"
        : container.database.user.name;
    profileImage = container.database.user.profileUrl;
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Center(
              child: CircleAvatar(
                backgroundImage: ImageServices.getNetworkImage(profileImage),
                radius: 75,
              ),
            ),
          ),
          Center(
              child: Text(
            "$name",
            style: TextStyle(fontSize: 20),
          )),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EditProfile();
                      },
                    ),
                  );
                },
                child: Text(
                  "Edit account",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
            ),
          ),
          logout()
        ],
      ),
    );
  }

  Widget paddedDivider() {
    return Divider(
      color: Colors.black,
      indent: 30,
    );
  }

  Widget fullDivider() {
    return Divider(color: Colors.black);
  }

  Widget logout() {
    final container = StateContainer.of(context);
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          container.database.auth.signOut();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Text(
            "Logout",
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
