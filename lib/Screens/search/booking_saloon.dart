import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/search/select_option.dart';

class BookSalon extends StatefulWidget {
  @override
  _VacanciesState createState() => _VacanciesState();
}

class _VacanciesState extends State<BookSalon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Saloon'),
        centerTitle: true,
      ),
      body: GridView.builder(
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
              onData: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectService())));
        },
        itemCount: 10,
      ),
    );
  }

  Widget cards({String pic, String name, Function onData}) {
    return InkWell(
      onTap: onData,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(pic),
              Text(
                name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.',
                style: TextStyle(fontSize: 10, height: 1.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
