import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDetails extends StatefulWidget {
  String type = "Type";
  String text = "Text";
  Function onPress;
  TextInputType inputType;

  EditDetails({this.type, this.text, this.onPress, this.inputType});

  _EditDetails createState() => _EditDetails();
}

class _EditDetails extends State<EditDetails> {
  TextEditingController controller;
  String txt;
  @override
  void initState() {
    super.initState();
    txt = widget.text;
    controller = TextEditingController(text: txt);
    controller.addListener((){
      txt = controller.text;
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
              controller: controller,
                keyboardType: widget.inputType ?? TextInputType.text,
                decoration: InputDecoration(
                    labelText: '${widget.type}',
                    hintText: 'Enter your ${widget.type}',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: RaisedButton(
              onPressed: () {
                if (widget.onPress != null)
                  widget.onPress(txt);

                Navigator.of(context).pop();
              },
              color: Colors.blue,
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
