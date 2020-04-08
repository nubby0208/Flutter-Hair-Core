import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';

class ShopMembers extends StatefulWidget {
  @override
  _ShopMembersState createState() => _ShopMembersState();
}

class _ShopMembersState extends State<ShopMembers> {
  var profileImage = [
    "assets/images/b1.png",
    "assets/images/b2.png",
    "assets/images/b3.png",
  ];
  var names = [
    "Mzimkhulu Ncube",
    "Mike Wazalsky",
    "Lilly Aldrin",
  ];

  Future<bool> onBackPress() {
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Members",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {},
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(profileImage[index]),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          title: Text(names[index]),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      );
                    },
                    itemCount: names.length),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: CustomButton.roundedButton(context,
                    background: secondaryColor,
                    txt: 'Edit Members',
                    textColor: Colors.black),
              )
            ],
          ),
        ));
  }
}
