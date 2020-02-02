import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/login.dart';
import 'package:hair_cos/Screens/Authentication/main.dart';
import 'package:hair_cos/Screens/UserHome/NavBar.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    print(user);
    return user == null ? loginView() : HomePage(user, context);
  }

  Widget HomePage(User userPass, context) {
    final container = StateContainer.of(context);

    container.database.user.uid = userPass.uid;

    container.database.getProfile(
      onData: (User user) {
        if (user.uid == null || userPass.anonymous){
          container.updateUser(User(uid: user.uid, anonymous: true));
        }else {
          container.updateUser(user);
        }
      },
    );

    return navBar();
  }
}
