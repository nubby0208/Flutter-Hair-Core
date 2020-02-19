import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/EditDetails.dart';
import 'package:hair_cos/Models/ShopSignupData.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/ShopSignUp/ShopServices.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';

class ShopSignUp extends StatefulWidget {
  @override
  _ShopSignUpState createState() => _ShopSignUpState();
}

class _ShopSignUpState extends State<ShopSignUp> {
  String shopName;
  String shopAddress;
  String shopEmail;
  String shopContact;
  String shopAbout;
  String shopServices;
  List<String> members = List<String>();
  List<String> servicesProvided = [];
  int totalItems = 0;
  bool isIndependant = false;

  @override
  Widget build(BuildContext context) {
    totalItems = 15 + (members.isEmpty ? 0 : members.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Signup"),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          return getWidget(index, context);
        },
      ),
    );
  }

  Widget getWidget(int i, context) {
    int buttonPos = totalItems - 1;
    int warningPos = totalItems - 2;
    int indpendantQ = totalItems - 3;
    int shopTypePos = totalItems - 4;
    int aboutTxt = totalItems - 5;
    int about = totalItems - 6;
    int aboutDividerPos = totalItems - 7;
    int addPos = totalItems - 8;
    int toMembers = 7;

    if (i == 0) {
      return ListTile(
        title: Text("Details"),
      );
    } else if (i == 1) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditDetails(
                  type: "Shop Name",
                  text: shopName,
                  onPress: (txt) {
                    setState(() {
                      shopName = txt == "" ? null : txt;
                    });
                  },
                );
              },
            ),
          );
        },
        leading: Icon(Icons.shop),
        title: Text("Shop name"),
        subtitle: Text(shopName ?? "Enter Shop name"),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
    } else if (i == 2) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditDetails(
                  type: "Shop Address",
                  text: shopAddress,
                  onPress: (txt) {
                    setState(() {
                      shopAddress = txt == "" ? null : txt;
                    });
                  },
                );
              },
            ),
          );
        },
        leading: Icon(Icons.location_on),
        title: Text("Shop address"),
        subtitle: Text(shopAddress ?? "Enter Shop address"),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
    } else if (i == 3) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditDetails(
                  type: "Shop Email",
                  text: shopEmail,
                  inputType: TextInputType.emailAddress,
                  onPress: (txt) {
                    setState(() {
                      shopEmail = txt == "" ? null : txt;
                    });
                  },
                );
              },
            ),
          );
        },
        leading: Icon(Icons.email),
        title: Text("Shop email"),
        subtitle: Text(shopEmail ?? "Enter Shop email"),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
    } else if (i == 4) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditDetails(
                  type: "Shop Contact",
                  text: shopContact,
                  inputType: TextInputType.phone,
                  onPress: (txt) {
                    setState(() {
                      shopContact = txt == "" ? null : txt;
                    });
                  },
                );
              },
            ),
          );
        },
        leading: Icon(Icons.email),
        title: Text("Shop contact"),
        subtitle: Text(shopContact ?? "Enter Shop contact"),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
    } else if (i == 5) {
      return Divider(
        color: Colors.black,
      );
    } else if (i == 6) {
      return ListTile(
        title: Text("Members"),
      );
    } else if (i == addPos) {
      return ListTile(
        onTap: () {
          if (totalItems < 40)
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return EditDetails(
                  type: "Shop Member",
                  text: null,
                  onPress: (txt) {
                    if (txt != null)
                      setState(() {
                        members.add(txt);
                      });
                  },
                );
              },
            ));
          else
            errorDialog("Max members reached", context);
        },
        leading: Icon(Icons.person_add),
        title: Text("Add member"),
        trailing: Icon(
          Icons.add_circle,
          color: Colors.blueAccent,
        ),
      );
    } else if (i == aboutDividerPos) {
      return Divider(
        color: Colors.black,
      );
    } else if (i == indpendantQ) {
      return ListTile(
        leading: Checkbox(
          value: isIndependant,
          onChanged: (val) {
            setState(() {
              isIndependant = val;
            });
          },
        ),
        title: Text("Are you an independant person"),
      );
    } else if (i == about) {
      return ListTile(
        title: Text("About"),
      );
    } else if (i == shopTypePos) {
      return ListTile(
        leading: Icon(Icons.apps),
        title: Text("Services provided"),
        subtitle: Text(shopServices ?? "No services selected yet"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ServicesProvided(
                  onPress: (List<String> services) {
                    servicesProvided = services;
                    if (services == null) {
                      shopServices = null;
                      return;
                    }
                    shopServices = "";
                    for (int i = 0; i < servicesProvided.length; i++) {
                      shopServices += "${servicesProvided[i]}\n";
                    }
                    setState(() {});
                  },
                  selectedServices: servicesProvided,
                );
              },
            ),
          );
        },
      );
    } else if (i == aboutTxt) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditDetails(
                  type: "Shop About",
                  text: shopAbout,
                  onPress: (txt) {
                    setState(() {
                      shopAbout = txt == "" ? null : txt;
                    });
                  },
                );
              },
            ),
          );
        },
        leading: Icon(Icons.info),
        title: Text("About"),
        subtitle: Text(shopAbout ?? "Enter optional about shop text"),
      );
    } else if (i == warningPos) {
      return ListTile(
        leading: Icon(
          Icons.warning,
          color: Colors.blueAccent,
        ),
        subtitle: Text(
          "To sign up as a shop you can sign up here "
          "and we can verify that your shop is LEGITAMATE. "
          "To sign up shop with multiple people one person "
          "add the people onto the shop after they have signed up",
          style: TextStyle(color: Colors.blueAccent),
        ),
      );
    } else if (i == buttonPos) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
          child: CustomButton.roundedButton(context,
              txt: "submit".toUpperCase(), onPress: () {
            signUpShop();
          }),
        ),
      );
    } else {
      return ListTile(
        onTap: () {
          setState(() {
            members.removeAt(i - toMembers);
          });
        },
        leading: Icon(Icons.person),
        title: Text(members[i - toMembers]),
        trailing: Icon(
          Icons.remove_circle,
          color: Colors.redAccent,
        ),
      );
    }
  }

  void errorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void signUpShop() {
    var container = StateContainer.of(context);
    if (User.userData.userId != null){
      errorDialog(
        "This account is already part of a shop, leave previous shop to create a new one",
        context,
      );
      return;
    }
    if (validateInfo()) {
      ShopSignUpData data = ShopSignUpData(
        creatorID: User.userData.userId,
        shopName: shopName,
        members: members,
        type: servicesProvided,
        about: shopAbout,
        email: shopEmail,
        contact: shopContact,
        address: shopAddress,
        isIndipendant: isIndependant,
      );
      Future result = container.database.signUpShop(data);
      print(result);
      if (result == null) {
        errorDialog(
          "This account is already part of a shop, leave previous shop to create a new one",
          context,
        );
      }

      Navigator.of(context).pop();
    } else {
      errorDialog("please input all fields", context);
    }
  }

  bool validateInfo() {
    if (shopName != null &&
        shopAddress != null &&
        shopEmail != null &&
        shopContact != null &&
        servicesProvided != null &&
        shopAbout != null) return true;

    return false;
  }
}
