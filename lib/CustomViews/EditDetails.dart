import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDetails extends StatefulWidget {
  String type = "Type";
  String text = "Text";

  EditDetails({this.type, this.text});

  _EditDetails createState() => _EditDetails();
}

class _EditDetails extends State<EditDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.type}"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: '${widget.type}',
                  hintText: 'Enter your ${widget.type}',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
              initialValue: widget.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.blue,
              child: Container(
                  height: 50,
                  child: Center(
                      child:
                          Text("Save", style: TextStyle(color: Colors.white)))),
            ),
          )
        ],
      ),
    );
  }
}
