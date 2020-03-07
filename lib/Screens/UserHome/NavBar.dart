import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Products/products.dart';
import 'package:hair_cos/Screens/UserAppointments/Appointments.dart';
import 'package:hair_cos/Screens/UserHome/Home.dart';
import 'package:hair_cos/Screens/UserProfile/Profile.dart';

class NavBar extends StatefulWidget {
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int selectedIndex = 0;

  Widget callPage(int index) {
    switch (index) {
      case 3:
        {
          return Profile();
        }
        break;
      case 2:
        {
          return Appointments();
        }
        break;
      case 1:
        {
          return Products();
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
    return MaterialApp(
      home: Scaffold(
        body: callPage(selectedIndex),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive), title: Text("Products")),
            BottomNavigationBarItem(
                icon: Icon(Icons.book), title: Text("Appointments")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile"))
          ],
        ),
      ),
      theme: Theme.of(context),
    );
  }
}
