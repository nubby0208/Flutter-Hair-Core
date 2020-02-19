import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/ShopAppointments/ShopOwnerAppointments.dart';
import 'package:hair_cos/Screens/ShopHome/ShopOwnerProfile.dart';
import 'package:hair_cos/Screens/ShopViewShop/ShopOwnerShop.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import 'package:provider/provider.dart';

class ShopNavBar extends StatefulWidget {
  @override
  _ShopNavBarState createState() => _ShopNavBarState();
}

class _ShopNavBarState extends State<ShopNavBar> {
  int selectedIndex = 0;

  Widget getPage(int index) {
    switch (index) {
      case 2:
        {
          return ShopOwnerProfile();
        }
        break;
      case 1:
        {
          return ShopOwnerAppointments();
        }
        break;
      default:
        {
          return ShopOwnerShop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return StreamProvider<DocumentSnapshot>.value(
      value: container.database.shopProfile,
      child: MaterialApp(
        home: Scaffold(
          body: getPage(selectedIndex),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), title: Text("Appointments")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Profile"))
            ],
          ),
        ),
        theme: Theme.of(context),
      ),
    );
  }
}
