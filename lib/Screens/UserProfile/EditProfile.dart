import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Images.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class EditProfile extends StatefulWidget {
  final DatabaseServices database;

  EditProfile({this.database});

  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  String profileImage;
  String name;
  String email;
  String mobile;
  String address;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container = StateContainer.of(context);
    setAttributes(container);
    profileImage = container.database.user.profileUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: ListView(children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10), child: getProfile()),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditDetails(
                    type: "Name",
                    text: name,
                    onPress: (name) {
                      User user = container.database.user;
                      user.name = name;
                      container.database.editProfile(user);
                      container.updateUser(user);
                    },
                  );
                },
              ),
            );
          },
          leading: Icon(Icons.person),
          title: Text("Name"),
          subtitle: Text(name),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(
          color: Colors.black,
          indent: 20,
        ),
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditDetails(
                type: "Email",
                text: email,
                onPress: (name) {
                  User user = container.database.user;
                  user.email = name;
                  container.database.editProfile(user);
                  container.updateUser(user);
                },
              );
            }));
          },
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text(email),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(
          color: Colors.black,
          indent: 20,
        ),
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditDetails(
                type: "Mobile",
                text: mobile,
                onPress: (name) {
                  User user = container.database.user;
                  user.mobile = name;
                  container.database.editProfile(user);
                  container.updateUser(user);
                },
              );
            }));
          },
          leading: Icon(Icons.phone),
          title: Text("Mobile"),
          subtitle: Text(mobile),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(
          color: Colors.black,
          indent: 20,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditDetails(
                    type: "Address",
                    text: address,
                    onPress: (name) {
                      User user = container.database.user;
                      user.address = name;
                      container.database.editProfile(user);
                      container.updateUser(user);
                    },
                  );
                },
              ),
            );
          },
          leading: Icon(Icons.location_on),
          title: Text("Address"),
          subtitle: Text(address),
          trailing: Icon(Icons.keyboard_arrow_right),
        )
      ]),
    );
  }

  Widget getProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
          ),
          CircleAvatar(
            backgroundImage: ImageServices.getNetworkImage(profileImage),
            radius: 75,
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                color: Colors.blue,
                onPressed: () async {
                  File file = await ImageServices.getImageFromCamera();
                  StateContainer.of(context).database.uploadProfilePicture(
                    file,
                    onData: (image) {
                      User user = StateContainer.of(context).database.user;
                      user.profileUrl = image;
                      StateContainer.of(context).updateUser(user);
                      setState(() {});
                    },
                  );
                },
                icon: Icon(
                  Icons.add_a_photo,
                  size: 40,
                ),
              ))
        ],
      ),
    );
  }

  void setAttributes(container) {
    name = StateContainer.of(context).database.user.isNameEmpty()
        ? "No name"
        : StateContainer.of(context).database.user.name;
    email = StateContainer.of(context).database.user.isEmailEmpty()
        ? "No email"
        : StateContainer.of(context).database.user.email;
    mobile = StateContainer.of(context).database.user.isMobileEmpty()
        ? "No mobile"
        : StateContainer.of(context).database.user.mobile;
    address = StateContainer.of(context).database.user.isAddressEmpty()
        ? "No address"
        : StateContainer.of(context).database.user.address;
  }
}

/**
 * Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
    image: AssetImage(profileImage), fit: BoxFit.fill)),
    )*/
