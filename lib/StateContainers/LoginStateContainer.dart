import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Services/Database.dart';

class StateContainer extends StatefulWidget {
  final Widget child;
  final DatabaseServices database;

  StateContainer({@required this.child, this.database});

  static _StateContainerState of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritedStateContainer>().data ;
  }

  @override
  _StateContainerState createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  DatabaseServices database;

  @override
  void initState() {
    super.initState();
    database = widget.database;
  }

  updateUser(User user){
    setState(() {
      database.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class InheritedStateContainer extends InheritedWidget {
  final _StateContainerState data;

  InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
