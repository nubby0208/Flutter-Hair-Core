import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            "About Inertia Cosmetics",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "The application provides businesses the means to connext with their customers"
                  "Customers get book appointments and businesses will be able see the "
                  "appointments and accept or decline them. ",
            ),
          ),
        ],
      ),
    );
  }
}
