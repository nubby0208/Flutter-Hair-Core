import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      case 2:
        {
          return Profile();
        }
        break;
      case 1:
        {
          return Appointments();
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
    );
  }
}
