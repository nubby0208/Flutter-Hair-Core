import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:typed_data';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File _image;
  String imageurl, _error;
  List<Asset> images = List<Asset>();
  List<String> imgUrls = List<String>();

  bool haveImage = false, loading = false;
  final pName = TextEditingController();
  final pSalePrice = TextEditingController();
  final pStock = TextEditingController();
  final pDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                    images.isNotEmpty ? buildGridView() : Container(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text("Product Picture"),
                              GestureDetector(
                                onTap: () {
                                  loadAssets();
                                },
                                child: Image(
                                  image: _image == null
                                      ? AssetImage('asserts/image_Plus.png')
                                      : FileImage(_image),
                                  height: 150,
                                  width: 100,
                                ),
                              )
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
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (images.isEmpty) {
                          setState(() {
                            loading = false;
                          });
                          Fluttertoast.showToast(msg: 'Please Select an image');
                        } else {
                          for (int i = 0; i < images.length; i++) {
                            imgUrls.add(await saveImage(
                                images[i],
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString()));
                          }

                          onSave();
                        }
                      },
                    )),
                  ],
                )),
          ),
        ));
  }

  Future saveImage(Asset asset, String name) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('${User.userData.userId}')
        .child('products')
        .child("$name.jpg");
    StorageUploadTask uploadTask = ref.putData(imageData);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<void> onSave() async {
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
            'photo': FieldValue.arrayUnion(imgUrls)
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

  Widget buildGridView() {
    return Container(
      height: 150,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pick Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
}
