import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/UserViewShop/ViewShop.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final names = ['People\'s Barber', 'Mike and Ken', 'Kenny all star'];
  final images = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg"
  ];
  final address = [
    "11 Bilby Gardens NG3 2GU",
    "52 Rosewarn Close BA2 1PB",
    "University of bath BA2 7AY"
  ];
  Widget searchBar = Text("HairCos");
  Icon searchIcon = Icon(Icons.search);
  String type = "list";
  var liked = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {
                    if (this.searchIcon.icon == Icons.search) {
                      this.searchIcon = Icon(Icons.cancel);
                      this.searchBar = TextField(
                          onSubmitted: (String value) {
                            this.searchIcon = Icon(Icons.search);
                            this.searchBar = Text("HairCos");
                            type = "list";
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(hintText: 'Search'));
                      type = "search";
                    } else {
                      this.searchIcon = Icon(Icons.search);
                      this.searchBar = Text("HairCos");
                      type = "list";
                    }
                  });
                },
                icon: searchIcon)
          ],
        ),
        body: getWidget(this.type));
  }

  Widget getWidget(String type) {
    switch (type) {
      case "list":
        {
          return getList();
        }
        break;
      case "search":
        {
          return getSearch();
        }
    }
  }

  Widget getSearch() {
    return Container(color: Colors.white, width: 1000, height: 1000);
  }

  Widget getList() {
    return ListView.separated(
      itemCount: names.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ViewShop(names[index], images[index]);
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          child: Image.asset(
                            images[index],
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.width * 0.95,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                liked[index] = !liked[index];
                              },
                            );
                          },
                          icon: Icon(
                            liked[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  " " + names[index],
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                Text(
                  "  " + address[index],
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                )
              ],
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.black);
      },
    );
  }
}
