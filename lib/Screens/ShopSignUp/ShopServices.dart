import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesProvided extends StatefulWidget {
  final Function onPress;
  final List<String> selectedServices;

  ServicesProvided({this.onPress, this.selectedServices});
  @override
  _ServicesProvidedState createState() => _ServicesProvidedState();
}

class _ServicesProvidedState extends State<ServicesProvided> {
  Map<String, bool> services;
  var serviceType = [];

  @override
  void initState() {
    super.initState();
    serviceType = ServicesTypes.serviceType;
    services = new Map();
    for (int i = 0; i < serviceType.length; i++) {
      if (widget.selectedServices != null) {
        if (widget.selectedServices.contains(serviceType[i]))
          services[serviceType[i]] = true;
        else
          services[serviceType[i]] = false;
      }else{
        services[serviceType[i]] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Services"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            onPressed: () {
              List<String> tempServices = [];
              for (int i = 0; i < serviceType.length; i++){
                if (services[serviceType[i]])
                  tempServices.add(serviceType[i]);
              }
              widget.onPress(tempServices.isEmpty ? null : tempServices);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: getLists(),
    );
  }

  Widget getLists() {
    return ListView.builder(
      itemCount: serviceType.length,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Checkbox(
              value: services[serviceType[index]],
              onChanged: (state) {
                setState(() {
                  services[serviceType[index]] = state;
                });
              },
            ),
            Text("${serviceType[index]}"),
          ],
        );
      },
    );
  }
}

class ServicesTypes{
  static var serviceType = [
    "Hair stylist",
    "Independant Owners",
    "EyeLash technician",
    "Manicures",
    "Pedicures",
    "Massage",
    "Other",
  ];

  static getBestMatch(String text){
    if (text == "Independant Owners")
      return "Other";

    Map map = Map();
    map["barber"] = "Hair stylist";
    map["hair stylist"] = "Hair stylist";

    map["eyeLash technician"] = "EyeLash technician";
    map["eyeLash technicians"] = "EyeLash technician";
    map["eyeLashes"] = "EyeLash technician";
    map["eyeLashe"] = "EyeLash technician";
    map["eyes"] = "EyeLash technician";
    map["eye"] = "EyeLash technician";
    map["lashes"] = "EyeLash technician";
    map["lash"] = "EyeLash technician";

    map["manicures"] = "Manicures";
    map["nails"] = "Manicures";
    map["finger nails"] = "Manicures";

    map["pedicures"] = "Pedicures";
    map["peducure"] = "Pedicures";

    map["massage"] = "Massage";
    map["massages"] = "Massage";

    map["other"] = "Other";
    map["Independant Owners"] = null;

    String toReturn = map[text.toLowerCase()];
    if (toReturn != null){
      return toReturn;
    }else{
      return text;
    }
  }
}
