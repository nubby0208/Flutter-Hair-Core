import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/UserProfile/EditProfile.dart';
import 'package:hair_cos/Services/Images.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  String profileImage;
  String name;
  var savedPlaces = ["Double X barbers", "K Scissors"];
  var container;

  @override
  void initState() {
    super.initState();
    profileImage = User.userData.userPhoto;
    name = User.userData.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: User.userData.userId != null ? content(context) : noProfile(),
    );
  }

  Widget noProfile() {
    return Center(
      child: InkWell(
        onTap: () {
          signOut();
        },
        child: Text("Sign in to View profile"),
      ),
    );
  }

  Widget content(BuildContext context) {
    return ListView(
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
          name,
          style: TextStyle(fontSize: 20),
        )),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfile();
                }));
              },
              child: Text(
                "Edit account",
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
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
                      image: AssetImage("asserts/barber_pic_1.jpg"),
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
                      image: AssetImage("asserts/barber_pic_1.jpg"),
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
              signOut();
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
            ),
          ),
        )
      ],
    );
  }

  void signOut() {
    container.database.auth.signOut();
  }
}
