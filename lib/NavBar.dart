import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Appointments/Appointments.dart';
import 'package:hair_cos/Home.dart';
import 'package:hair_cos/Profile/Profile.dart';

class navBar extends StatefulWidget {
  _navBar createState() => _navBar();
}

class _navBar extends State<navBar> {
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
          backgroundColor: Colors.blue,
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
    );
  }
}
