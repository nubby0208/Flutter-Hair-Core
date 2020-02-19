import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomExpandableView extends StatefulWidget {
  Widget title = Text("Tittle");
  Widget expandedTitle = Text("UnTittle");
  Widget expanded = Text("Expanded");
  bool isExpanded = false;

  CustomExpandableView(
      {@required this.title,
      @required this.expandedTitle,
      @required this.expanded,
      this.isExpanded});

  _CustomExpandableView createState() => _CustomExpandableView();
}

class _CustomExpandableView extends State<CustomExpandableView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.isExpanded ? widget.expanded : Container(),
        InkWell(
            onTap: () {
              setState(() {
                if (widget.isExpanded)
                  widget.isExpanded = false;
                else
                  widget.isExpanded = true;
              });
            },
            child: widget.isExpanded ? widget.expandedTitle : widget.title)
      ],
    );
  }
}

class ExpandableView extends StatefulWidget {
  Widget title = Text("Tittle");
  Widget expanded = Text("Expanded");
  bool isExpanded = false;

  ExpandableView(
      {@required this.title, @required this.expanded, this.isExpanded});

  _ExpandableView createState() => _ExpandableView();
}

class _ExpandableView extends State<ExpandableView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
            onTap: () {
              setState(() {
                if (widget.isExpanded)
                  widget.isExpanded = false;
                else
                  widget.isExpanded = true;
              });
            },
            child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: widget.title),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.isExpanded)
                            widget.isExpanded = false;
                          else
                            widget.isExpanded = true;
                        });
                      },
                      icon: Icon(widget.isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up))
                ]))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 0),
            child: widget.isExpanded
                ? widget.expanded
                : Container(
                    width: 0,
                    height: 0,
                  ))
      ],
    );
  }
}
