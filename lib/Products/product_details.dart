import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Models/products.dart';
import 'package:stripe_payment/stripe_payment.dart';

class ProductDeatils extends StatefulWidget {
  @override
  _ProductDeatilsState createState() => _ProductDeatilsState();
}

class _ProductDeatilsState extends State<ProductDeatils> {
  List<int> stock = List<int>();
  int max, _selected = 1;
  Token _paymentToken;
  String _error;
  PList list = PList();
  PaymentMethod _paymentMethod;
  @override
  void initState() {
    super.initState();
    max = int.parse(Product.productData.instock);
    for (int i = 0; i < max; i++) {
      stock.add(i + 1);
    }
    StripePayment.setOptions(StripeOptions(
      publishableKey: "pk_test_S3bXzfFKiMIEGGFL8Q1LoikR002CKBRgyK",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${Product.productData.title}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.width / 2,
                  width: double.infinity,
                  child: Carousel(
                    images: Product.productData.pictures.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(36),
                                      child: Image.network(
                                        i,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ))));
                        },
                      );
                    }).toList(),
                  )),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Price:',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: ' \$${Product.productData.price}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ])),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Free Delivery',
                          style: TextStyle(color: Colors.blueAccent)),
                      TextSpan(
                          text: ' on orders above \$3000',
                          style: TextStyle(color: Colors.black))
                    ])),
                    SizedBox(height: 10),
                    Text(
                      'In stock.',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 30,
                      width: 120,
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Qty: '),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: DropdownButton(
                                  isExpanded: true,
                                  style: TextStyle(color: primaryColor),
                                  value: _selected,
                                  items: stock.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text('$value'),
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      _selected = item;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          list.description = Product.productData.description;
                          list.title = Product.productData.title;
                          list.photo = Product.productData.pictures[0];
                          list.price = Product.productData.price;
                          Product.productData.cart.add(list);
                          print(Product.productData.cart.length);
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              builder: (_) => showCart(context));
                        },
                        child: Text('Add to Basket'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          StripePayment.paymentRequestWithCardForm(
                                  CardFormPaymentRequest())
                              .then((paymentMethod) {
                            Fluttertoast.showToast(
                                msg: 'Received ${paymentMethod.id}');
                            setState(() {
                              _paymentMethod = paymentMethod;
                            });
                          }).catchError(setError);
                        },
                        child: Text('Buy Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }

  showCart(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 300,
      child: ListView.builder(
          itemCount: Product.productData.cart.length,
          itemBuilder: (context, index) => imageCard(index)),
    );
  }

  imageCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Container(
        height: MediaQuery.of(context).size.width / 2.5,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Product.productData.cart[index].photo != null ||
                        Product.productData.cart[index].photo != ""
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(themeColor),
                            ),
                            width: 50.0,
                            height: 50.0,
                            padding: EdgeInsets.all(15.0),
                          ),
                          imageUrl: Product.productData.cart[index].photo,
                          /* width: 60.0,
                            height: 60.0, */
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        child: Text('Image Error'),
                      )),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      '${Product.productData.cart[index].title}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${Product.productData.cart[index].description}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.yellow,
                        ),
                        Text('265'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Text('\$',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        Text(
                          '${Product.productData.cart[index].price}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void setError(dynamic error) {
    Fluttertoast.showToast(msg: '$error');
    setState(() {
      _error = error.toString();
    });
  }
}
