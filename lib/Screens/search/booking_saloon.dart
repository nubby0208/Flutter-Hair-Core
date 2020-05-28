import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/search/shop_home_servies.dart';
import 'package:hair_cos/Services/Database.dart';
import 'package:hair_cos/Services/Images.dart';

class BookSalon extends StatefulWidget {
  @override
  _VacanciesState createState() => _VacanciesState();
}

class _VacanciesState extends State<BookSalon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Type'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: DatabaseServices(User.userData.userId).independentServices,
        builder: (context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Map> data = snapshot.data;
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .7,
            ),
            itemBuilder: (context, index) {
              return cards(
                data: data[index],
                onData: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarberShop(type: data[index]),
                  ),
                ),
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }

  Widget cards({Map data, Function onData}) {
    return InkWell(
      onTap: onData,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: ListView(
            children: <Widget>[
              ImageServices.getServiceStyleImage(data['Image']),
              Text(
                data['Name'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(data['Text'], style: TextStyle(fontSize: 10, height: 1.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
GridView.builder(
        physics: BouncingScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .7),
        itemBuilder: (context, index) {
          return cards(
            pic: index == 0
                ? 'assets/images/wedding.png'
                : index == 1
                    ? "assets/images/office.png"
                    : index == 2
                        ? "assets/images/prom.png"
                        : index == 3
                            ? "assets/images/urban.png"
                            : index == 4
                                ? "assets/images/wedding.png"
                                : "assets/images/black.png",
            name: index == 0
                ? 'Wedding Styles'
                : index == 1
                    ? "Work/Buisness Styles"
                    : index == 2 ? "Prom & Party Styles" : 'Urban Styles',
            onData: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarberShop(),
              ),
            ),
          );
        },
        itemCount: 10,
      )
 */
