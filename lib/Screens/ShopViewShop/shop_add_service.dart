import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Constants/input_form_field.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';

class ShopAddService extends StatefulWidget {
  @override
  _ShopAddServiceState createState() => _ShopAddServiceState();
}

class _ShopAddServiceState extends State<ShopAddService> {
  padding(double height) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service / Booking Type'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              padding(10.0),
              Text(
                'Add Service / Booking Type',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              FormFeild(
                userPassword: null,
                obsecure: false,
                hint: 'Category Name',
              ),
              FormFeild(
                userPassword: null,
                obsecure: false,
                hint: 'Service/ Style Name',
              ),
              FormFeild(
                userPassword: null,
                obsecure: false,
                hint: 'Duration',
              ),
              FormFeild(
                userPassword: null,
                obsecure: false,
                hint: 'Price',
                inputType: TextInputType.number,
              ),
              Text(
                'upload preview pictures',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              padding(MediaQuery.of(context).size.width / 3.7),
              CustomButton.roundedButton(context,
                  txt: 'Save',
                  background: secondaryColor,
                  textColor: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
