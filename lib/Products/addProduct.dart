import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hair_cos/Constants/color.dart';

import 'package:flutter/material.dart';
import 'package:hair_cos/Helper/image_picker_handler.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  String imageurl;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  String _selectedItem;
  List categoryList = List();
  final pName = TextEditingController();
  final pSalePrice = TextEditingController();
  final pStock = TextEditingController();
  final pDescription = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.build(primaryColor, Colors.white, true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    pName.dispose();
    pSalePrice.dispose();
    pStock.dispose();
    pDescription.dispose();
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffECECEC),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text('Add Product'),
          ),
        ),
        body: ModalProgressHUD(
            inAsyncCall: loading,
            child: WillPopScope(child: mainScreen(), onWillPop: onBackPress)));
  }

  mainScreen() {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text("Product Picture"),
                              GestureDetector(
                                onTap: () {
                                  imagePicker.showDialog(context);
                                  print("aaaaaaaaaaa");
                                },
                                child: Image(
                                  image: _image == null
                                      ? AssetImage('asserts/image_Plus.png')
                                      : FileImage(_image),
                                  height: 150,
                                  width: 100,
                                ),
                              )
                              /* Image.asset(
                                      "assets/image/image_Plus.png",
                                      height: 150,
                                      width: 100,
                                    ) */
                            ],
                          ),
                          flex: 4,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Enter Product Name"),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                ),
                                child: TextField(
                                  controller: pName,
                                  decoration: InputDecoration(
                                    hintText: "EnterName",
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        Text("Sale Price"),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: TextField(
                                            controller: pSalePrice,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "000",
                                            ),
                                          ),
                                        ),
                                      ])),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        Text("Stock Level"),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: TextField(
                                            controller: pStock,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "000",
                                            ),
                                          ),
                                        ),
                                      ])),
                                ],
                              )
                            ],
                          ),
                          flex: 6,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Description"),
                          Container(
                            margin:
                                EdgeInsets.only(top: 5, left: 10, right: 10),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: TextField(
                              maxLines: 5,
                              controller: pDescription,
                              decoration: InputDecoration(
                                hintText: "Enter detail of product",
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                        child: RaisedButton(
                      padding: EdgeInsets.only(left: 80, right: 80),
                      child: Text(
                        'save',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: primaryColor,
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });

                        uploadFile();
                      },
                    )),
                  ],
                )),
          ),
        ));
  }

  Future uploadFile() async {
    if (_image != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference reference =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putFile(_image);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
        imageurl = downloadUrl;
        setState(() {
          onSendMessage();
        });
      }, onError: (err) {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      });
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: 'Please Select an image');
    }
  }

  Future<void> onSendMessage() async {
    if (pName.text.isNotEmpty ||
        pSalePrice.text.isNotEmpty ||
        pDescription.text.isNotEmpty ||
        pStock.text.isNotEmpty) {
      var documentReference =
          Firestore.instance.collection('products').document();

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'title': pName.text.trim(),
            'price': pSalePrice.text.trim(),
            'description': pDescription.text.trim(),
            'stock': pStock.text.trim(),
            'photo': imageurl
          },
        );
      });
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: 'Please enter details');
    }
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
    return _image;
  }
}
