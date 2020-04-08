import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Models/products.dart';
import 'package:hair_cos/Products/payment_screen.dart';

class ProductDeatils extends StatefulWidget {
  @override
  _ProductDeatilsState createState() => _ProductDeatilsState();
}

class _ProductDeatilsState extends State<ProductDeatils> {
  List<int> stock = [1, 2, 3, 4, 5];
  int max, _selected = 1;
  /*
  Token _paymentToken;
  String _error;
  PList list = PList();
  PaymentMethod _paymentMethod;
  var day = DateTime.now();
  var newDay;
  var formatter;
  String formatedDay, formatedMonth; */
  @override
  void initState() {
    super.initState();
    /*  max = int.parse(Product.productData.instock);
    for (int i = 0; i < max; i++) {
      stock.add(i + 1);
    }
    StripePayment.setOptions(StripeOptions(
      publishableKey: "pk_test_S3bXzfFKiMIEGGFL8Q1LoikR002CKBRgyK",
    ));
    setState(() {
      newDay = day.add(Duration(days: 3));
    });
    formatter = new DateFormat('EEEE');
    formatedDay = formatter.format(newDay);
    formatter = new DateFormat('MMMM');
    formatedMonth = formatter.format(newDay); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              /* SizedBox(
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
                  )), */
              Container(
                child: Image.asset('assets/images/scissor.png'),
              ),
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
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      TextSpan(
                        text: ' \$ 966',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Free Delivery',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' on orders above \$2000',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                    ])),
                    SizedBox(height: 10),
                    Text(
                      'Etiam viverra sed lectus sed fringilla. Suspendisse ante justo, tempor eget sodales sed, rutrum vitae justo. Nulla luctus, sem in tincidunt vehicula, lectus purus dapibus sem, a efficitur tellus erat non risus. Nam porttitor in libero in dapibus. Suspendisse sed ex ut diam sodales accumsan vitae nec leo. Ut interdum commodo felis non convallis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In varius sem enim, ut blandit arcu lobortis sit amet. Aenean hendrerit pharetra nulla, a volutpat nibh bibendum ac. Sed et egestas nisl.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                    /*  Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          /*  list.description = Product.productData.description;
                          list.title = Product.productData.title;
                          list.photo = Product.productData.pictures[0];
                          list.price = Product.productData.price;
                          list.quantity = _selected.toString();
                          Product.productData.cart.add(list); */
                          print(Product.productData.cart.length);
                          Fluttertoast.showToast(msg: 'Product added to cart');
                          /* showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              builder: (_) => showCart(context)); */
                        },
                        child: Text('Add to Basket'),
                      ),
                    ), */
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40,
                      width: double.infinity,
                      child: RaisedButton(
                        color: secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen2()));
                        },
                        child: Text('Buy Now'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Add to cart',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                      ),
                    )
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
}
