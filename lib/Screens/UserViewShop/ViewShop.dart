import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/CommentView.dart';
import 'package:hair_cos/CustomViews/ExpandableText.dart';
import 'package:hair_cos/Screens/UserViewShop/ViewBookingTypes.dart';
import 'package:hair_cos/Screens/UserViewShop/ViewAllComments.dart';
import 'package:hair_cos/Services/Images.dart';

class ViewShop extends StatefulWidget {
  final String name;
  final String profilePicture;

  ViewShop(this.name, this.profilePicture);

  _ViewShop createState() => _ViewShop();
}

class _ViewShop extends State<ViewShop> {
  final profileImages = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg"
  ];

  final int rating = 3;
  final String comment =
      "Best barber in the whole area, went today and even gave me a discount";
  final String commentPic = "asserts/barber_pic_1.jpg";
  final String commentName = "Mzimkhulu Ncube";

  final names = ['Zic', 'Ken', 'Caleb'];
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.name),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ImageServices.getNetworkImage(
                      widget.profilePicture,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    liked = !liked;
                  });
                },
                icon: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "About",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0), child: about()),
              Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Memebers",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: members(context)),
              Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Pictures",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: photos(context)),
              Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Comments",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: comments(context)),
              Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("Open Times", style: TextStyle(fontSize: 20))),
              dates(context),
              Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Contact",
                    style: TextStyle(fontSize: 20),
                  )),
              contact(context),
              Divider(
                color: Colors.black,
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ViewBookingTypes();
          }));
        },
        icon: Icon(Icons.book),
        label: Text("BOOK"),
      ),
    );
  }

  Widget comments(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommentView(
          image: commentPic,
          name: commentName,
          text: comment,
          rating: rating,
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ViewAllComments();
            }));
          },
          child: Text(
            "View more comments",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget photos(BuildContext context) {
    return SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: profileImages.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    bringupdialog(context, profileImages[index]);
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Column(children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            child: Image.asset(
                              profileImages[index],
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ))
                      ])));
            }));
  }

  Widget about() {
    String text =
        "Luxe Barber & Shave Lounge is an upscale experience, where we blend old school charm and new school freshness to truly groom our clients. Our barbershop is located in The Palmer House, a Hilton Hotel that's in the heart of the loop, where our guests are invited to experience true luxury. Our master level barbers specialize in tapers, fades, hot towel razor shaves, facials, coloring, and lining corrections. Hair fiber treatments and steam aromatherapy are also available inside our refined space, where we understand the importance of showcasing elegance.";

    return ExpandableText(
      text: text,
      limit: 100,
    );
  }

  Widget contact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("Mzincube161@gmail.com",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("07776218897",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                )))
      ],
    );
  }

  Widget members(BuildContext context) {
    return SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: profileImages.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Column(children: <Widget>[
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(profileImages[index]),
                                fit: BoxFit.fill))),
                    Text(names[index])
                  ]));
            }));
  }

  Widget dates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Monday"),
                    Spacer(),
                    Text("09:15 - 17:15",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Tuesday"),
                    Spacer(),
                    Text("09:15 - 17:15",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Wednesday"),
                    Spacer(),
                    Text("09:15 - 17:15",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Thursday"),
                    Spacer(),
                    Text("09:15 - 17:15",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Friday"),
                    Spacer(),
                    Text("09:15 - 17:15",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Saturday"),
                    Spacer(),
                    Text("10:15 - 17:15",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text("Sunday"),
                    Spacer(),
                    Text("Closed",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )))
      ],
    );
  }

  void bringupdialog(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.white,
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
                        ))),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
