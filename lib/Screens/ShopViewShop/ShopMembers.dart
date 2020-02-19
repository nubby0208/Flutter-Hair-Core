import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopMembers extends StatefulWidget {
  @override
  _ShopMembersState createState() => _ShopMembersState();
}

class _ShopMembersState extends State<ShopMembers> {
  var profileImage = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg",
  ];
  var names = [
    "Mzimkhulu Ncube",
    "Mike Wazalsky",
    "Lilly Aldrin",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5,
                    ),
                  ],
                ),
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
              ),
            );
          },
          itemCount: names.length),
    );
  }
}
