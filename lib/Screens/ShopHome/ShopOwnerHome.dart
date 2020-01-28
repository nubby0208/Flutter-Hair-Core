import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/main.dart';
import 'package:hair_cos/Screens/UserProfile/EditProfile.dart';
import 'package:hair_cos/Screens/ShopAppointments/ShopOwnerAppointments.dart';
import 'package:hair_cos/Screens/ShopImages/ShopOwnerImages.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopOwnerShop.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class ShopOwnerHome extends StatefulWidget {
  ShopOwnerHome();

  _ShopOwnerHome createState() => _ShopOwnerHome();
}

class _ShopOwnerHome extends State<ShopOwnerHome> {
  final String profileImage = "asserts/barber_pic_1.jpg";
  String name;

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    name = container.database.user.isNameEmpty()
        ? "No name"
        : container.database.user.name;

    return Scaffold(
      appBar: AppBar(title: Text("Your home")),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(profileImage),
                    fit: BoxFit.fill,
                  ),
                ),
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
          fullDivider(),
          ListTile(
            title: Text("View your shop"),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ShopOwnerShop();
                  },
                ),
              );
            },
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
          ),
          paddedDivider(),
          ListTile(
            title: Text("Appointments"),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ShopOwnerAppointments();
                  },
                ),
              );
            },
          ),
          fullDivider(),
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
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return MyApp();
            },
          ), (e) => false);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Text("Logout",
              style: TextStyle(
                fontSize: 25,
                color: Colors.blue,
              )),
        ),
      ),
    );
  }
}
