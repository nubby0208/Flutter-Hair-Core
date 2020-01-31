import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/Authentication/main.dart';
import 'package:hair_cos/Screens/UserProfile/EditProfile.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final String profileImage = "asserts/barber_pic_1.jpg";
  String name;
  final savedPlaces = ["Double X barbers", "K Scissors"];

  @override
  Widget build(BuildContext context) {
    var container = StateContainer.of(context);
    name = container.database.user.isNameEmpty()
        ? "No name"
        : container.database.user.name;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: container.database.user.anonymous
            ? Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MyApp();
                      }),
                      (e) => false,
                    );
                  },
                  child: Text("Sign in to View profile"),
                ),
              )
            : ListView(children: <Widget>[
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
                  name,
                  style: TextStyle(fontSize: 20),
                )),
                Center(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditProfile();
                            }));
                          },
                          child: Text(
                            "Edit account",
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ))),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Text(
                      "Saved Places",
                      style: TextStyle(fontSize: 20),
                    )),
                ListTile(
                  leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(profileImage),
                              fit: BoxFit.fill))),
                  title: Text(savedPlaces[0]),
                  subtitle: Text("11 Bilby Gardens NG3 2GU"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.black,
                  indent: 50,
                ),
                ListTile(
                  leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(profileImage),
                              fit: BoxFit.fill))),
                  title: Text(savedPlaces[1]),
                  subtitle: Text("56 Rosewarn Close BA2 1PB"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }), (e) => false);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                            "Logout",
                            style: TextStyle(fontSize: 25, color: Colors.blue),
                          ),
                        )))
              ]));
  }
}
