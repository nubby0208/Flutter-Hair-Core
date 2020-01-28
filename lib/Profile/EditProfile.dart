import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Profile/EditDetails.dart';

class EditProfile extends StatefulWidget {
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  String profileImage = "asserts/barber_pic_1.jpg";

  @override
  Widget build(BuildContext context) {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditDetails(
                type: "Name",
                text: "Mzimkhulu Ncube",
              );
            }));
          },
          leading: Icon(Icons.person),
          title: Text("Name"),
          subtitle: Text("Mzimkhulu Ncube"),
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
                text: "Mzincube161@gmail.com",
              );
            }));
          },
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text("Mzincube161@gmail.com"),
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
                text: "07776218897",
              );
            }));
          },
          leading: Icon(Icons.phone),
          title: Text("Mobile"),
          subtitle: Text("07776218897"),
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
                type: "Address",
                text: "11 Bilby Gardens NG3 2GU",
              );
            }));
          },
          leading: Icon(Icons.location_on),
          title: Text("Address"),
          subtitle: Text("11 Bilby Gardens NG3 2GU"),
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
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(profileImage), fit: BoxFit.fill)),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                color: Colors.blue,
                onPressed: () {},
                icon: Icon(
                  Icons.add_a_photo,
                  size: 40,
                ),
              ))
        ],
      ),
    );
  }
}
