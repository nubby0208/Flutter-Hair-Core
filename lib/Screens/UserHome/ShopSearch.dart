import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/ShopSignUp/ShopServices.dart';
import 'package:hair_cos/Screens/UserViewShop/ViewShop.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/Services/Images.dart';

class ShopSearch extends StatefulWidget {
  String searchType;

  ShopSearch({this.searchType});

  @override
  _ShopSearchState createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  var names = [];
  var images = [];
  var address = [];
  Widget searchBar = Text("Search");
  Icon searchIcon = Icon(Icons.search);
  String type = "list";
  var services = [];
  var liked = [];
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    search(widget.searchType);
  }

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
                      searchPressed();
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Search'),
                    controller: textController,
                  );
                  type = "search";
                } else {
                  searchPressed();
                }
              });
            },
            icon: searchIcon,
          )
        ],
      ),
      body: names.isNotEmpty
          ? getWidget(this.type)
          : Container(
              child: Center(
                child: Text("No shops provide this service yet."),
              ),
            ),
    );
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
      default:
        {
          return Loading();
        }
    }
  }

  Widget getSearch() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
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
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: ImageServices.getNetworkImage(images[index]),
                            fit: BoxFit.fill,
                          ),
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
                          liked[index] ? Icons.favorite : Icons.favorite_border,
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
              ),
              Text(
                "  " + services[index],
                style: TextStyle(color: Colors.black54, fontSize: 15),
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.black);
      },
    );
  }

  void search(String searchTerm) {
    DatabaseShopServices db = DatabaseShopServices(User());
    db.searchShops(
      text: searchTerm,
      onData: (QuerySnapshot snapshot) {
        setState(() {
          resetFields();
          snapshot.documents.forEach(
            (element) {
              names.add(element.data['ShopName']);
              address.add(element.data['Address']);
              images.add(element.data['ProfileUrl']);
              liked.add(false);
              services.add(getShorterStringFromList(element.data['Type']));
            },
          );
        });
      },
    );
  }

  void searchPressed() {
    this.searchIcon = Icon(Icons.search);
    this.searchBar = Text("HairCos");
    type = "list";
    print(textController.text);
    search(ServicesTypes.getBestMatch(textController.text));
  }

  void resetFields() {
    names = [];
    address = [];
    images = [];
    liked = [];
    services = [];
  }

  String getShorterStringFromList(List<dynamic> data){
    String toReturn = "";
    for (int i = 0; i < data.length; i++){
      toReturn += "${data[i]}";
      if (toReturn.length > 30) {
        toReturn = toReturn.substring(0, 30);
        break;
      }
      if (i < data.length-1)
        toReturn += ",\n  ";
    }
    return toReturn;
  }
}
