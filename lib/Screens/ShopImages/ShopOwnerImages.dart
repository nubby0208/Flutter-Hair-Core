import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopOwnerImages extends StatefulWidget {
  _ShopOwnerImages createState() => _ShopOwnerImages();
}

class _ShopOwnerImages extends State<ShopOwnerImages> {
  final images = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Images"),
        ),
        body: ListView.builder(
          itemCount: images.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return index > 0
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Image.asset(
                            images[index - 1],
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.width * 0.95,
                            fit: BoxFit.fill,
                          )),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {},
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            iconSize: 30,
                          ))
                    ]))
                : RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Add Photo",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_photo_alternate),
                            )
                          ]),
                    ),
                  );
          },
        ));
  }
}
