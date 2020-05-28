import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Products/products.dart';
import 'package:hair_cos/Screens/Drawer/drawer.dart';
import 'package:hair_cos/Screens/UserAppointments/Appointments.dart';
import 'package:hair_cos/Screens/UserHome/Home.dart';
import 'package:hair_cos/Screens/search/booking_saloon.dart';
import 'package:hair_cos/Screens/search/select_option.dart';

class NavBar extends StatefulWidget {
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget callPage(int index) {
    switch (index) {
      case 3:
        {
          return Products();
        }
        break;
      case 2:
        {
          return Appointments();
        }
        break;
      case 1:
        {
          return SelectService();
        }
        break;
      default:
        {
          return Home();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerFull(context, size),
      body: callPage(selectedIndex),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey[400],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          if (index >= 4) {
            _scaffoldKey.currentState.openDrawer();
            return;
          }
          setState(() {
            selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/images/calander.png',
              ),
              height: 20,
              width: 20,
              color: selectedIndex == 2 ? secondaryColor : null,
            ),
            title: Text("Appointments"),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/images/products.png',
              ),
              height: 20,
              width: 20,
              color: selectedIndex == 3 ? secondaryColor : null,
            ),
            title: Text("Products"),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/images/profile.png',
              ),
              height: 20,
              width: 20,
              color: selectedIndex == 4 ? secondaryColor : null,
            ),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
