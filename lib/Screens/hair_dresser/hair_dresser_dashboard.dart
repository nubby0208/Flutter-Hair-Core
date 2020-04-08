import 'package:flutter/material.dart';
import 'package:hair_cos/Screens/drawer.dart';
import 'package:hair_cos/Screens/hair_dresser/package_details.dart';
import 'package:hair_cos/Screens/hair_dresser/settings.dart';
import 'package:hair_cos/CustomViews/app_bar.dart';

class HairDresserDashboard extends StatefulWidget {
  @override
  _HairDresserDashboardState createState() => _HairDresserDashboardState();
}

class _HairDresserDashboardState extends State<HairDresserDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     Size size= MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
          )),
      drawer: DrawerFull(context, size),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                    onPressed: null,
                    disabledColor: Color(0xffFDF3BD),
                    color: Color(0xffFDF3BD),
                    icon: Icon(Icons.calendar_today),
                    label: Text('Date')),
                FlatButton.icon(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HairDresserSettings())),
                    disabledColor: Color(0xffFDF3BD),
                    icon: Icon(Icons.settings),
                    color: Color(0xffFDF3BD),
                    label: Text(''))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => imageCard(index)),
            ),
          ],
        ),
      ),
    );
  }

  imageCard(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HairdresserPackage()));
      },
      child: Card(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.width / 2.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Image.asset('assets/images/barber_Close.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'John M. Anderson',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                            Text(
                              '17  Broomfield Place, STON EASTON,BA3 6WD',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              maxLines: 2,
                            ),
                            Text(
                              '24/04/2020',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Black hair - High Top',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  ),
                ),
                Flexible(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    'Etiam viverra sed lectus sed fringilla. Suspendisse ante justo, tempor eget sodales sed, rutrum vitae justo. Nulla luctus, sem in tincidunt vehicula, lectus purus dapibus sem, a efficitur tellus erat non risus. Nam porttitor in libero in dapibus. Suspendisse sed ex ut diam sodales accumsan vitae nec leo. Ut interdum commodo felis non convallis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In varius sem enim, ut blandit arcu lobortis sit amet. Aenean hendrerit pharetra nulla, a volutpat nibh bibendum ac. Sed et egestas nisl.',
                    maxLines: 3,
                    style: TextStyle(height: 1.4),
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
