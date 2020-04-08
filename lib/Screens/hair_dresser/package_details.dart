import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';
import 'package:hair_cos/CustomViews/app_bar.dart';
import 'package:hair_cos/Screens/drawer.dart';
import 'package:hair_cos/Screens/hair_dresser/accept_screen.dart';

class HairdresserPackage extends StatefulWidget {
  @override
  _HairdresserPackageState createState() => _HairdresserPackageState();
}

class _HairdresserPackageState extends State<HairdresserPackage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  padd(size) {
    return SizedBox(
      height: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          child: CustomAppBar(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
          ),
          preferredSize: Size.fromHeight(60)),
      drawer: DrawerFull(context, size),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/barber.png',
                fit: BoxFit.cover,
              ),
              Text(
                'John M. Anderson',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
              padd(10.0),
              Text(
                '17  Broomfield Place, STON EASTON,BA3 6WD',
                style: TextStyle(
                  fontSize: 13,
                ),
                maxLines: 2,
              ),
              padd(10.0),
              Text(
                'Black hair - High Top',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
              padd(10.0),
              Text(
                '100\$',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: secondaryColor),
              ),
              Text(
                'Etiam viverra sed lectus sed fringilla. Suspendisse ante justo, tempor eget sodales sed, rutrum vitae justo. Nulla luctus, sem in tincidunt vehicula, lectus purus dapibus sem, a efficitur tellus erat non risus. Nam porttitor in libero in dapibus. Suspendisse sed ex ut diam sodales accumsan vitae nec leo. Ut interdum commodo felis non convallis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In varius sem enim, ut blandit arcu lobortis sit amet. Aenean hendrerit pharetra nulla, a volutpat nibh bibendum ac. Sed et egestas nisl.',
                style: TextStyle(height: 1.4),
              ),
              padd(10.0),
              Text(
                'Pictures',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              padd(10.0),
              Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return imageCarsole(index);
                    }),
              ),
              padd(10.0),
              CustomButton.roundedButton(context,
                  txt: 'Accept',
                  background: secondaryColor,
                  onPress: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AcceptScreen())),
                  textColor: Colors.black)
            ],
          ),
        ),
      ),
    );
  }

  imageCarsole(int index) {
    return Image.asset(index == 0
        ? 'assets/images/spikes.png'
        : index == 1 ? 'assets/images/short.png' : 'assets/images/bald.png');
  }
}
