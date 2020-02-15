import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/Loading.dart';
import 'package:hair_cos/Models/ShopUser.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Authentication/Welcome.dart';
import 'package:hair_cos/Screens/ShopHome/ShopNavBar.dart';
import 'package:hair_cos/Screens/UserHome/NavBar.dart';
import 'package:hair_cos/StateContainers/LoginStateContainer.dart';
import 'package:provider/provider.dart';

enum ScreenChoiceState { choosingScreen, shopScreen, userScreen }

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return user == null ? WelcomeScreen() : homePage(user, context);
  }

  Widget homePage(User userPass, context) {
    final container = StateContainer.of(context);
    container.database.user.uid = userPass.uid;
    return StreamBuilder<User>(
      stream: container.database.userProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          container.database.user = snapshot.data;
          if (snapshot.data.sid != null) {
            container.database.shopUser = ShopUser(sid: snapshot.data.sid);
            return MakeChoiceOfScreen();
          } else {
            return navBar();
          }
        } else {
          return Loading();
        }
      },
    );
  }
}

class MakeChoiceOfScreen extends StatefulWidget {
  @override
  _MakeChoiceOfScreenState createState() => _MakeChoiceOfScreenState();
}

class _MakeChoiceOfScreenState extends State<MakeChoiceOfScreen> {
  ScreenChoiceState widgetState;

  @override
  void initState() {
    super.initState();
    widgetState = ScreenChoiceState.choosingScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetState == ScreenChoiceState.choosingScreen
          ? content()
          : (widgetState == ScreenChoiceState.shopScreen
              ? ShopNavBar()
              : navBar()),
    );
  }

  Widget content() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        userCard(
          picture: "asserts/no_profile.jpg",
          txt: "Login as Normal User",
          onPress: () {
            setState(() {
              widgetState = ScreenChoiceState.userScreen;
            });
          },
        ),
        userCard(
          picture: "asserts/shop_picture.jpg",
          txt: "Login into shop",
          onPress: () {
            setState(() {
              widgetState = ScreenChoiceState.shopScreen;
            });
          },
        ),
      ],
    );
  }

  Widget userCard(
      {@required String picture,
      @required String txt,
      @required Function onPress}) {
    return Card(
      child: InkWell(
        onTap: () {
          onPress();
        },
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(picture),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(txt),
          ],
        ),
      ),
    );
  }
}
