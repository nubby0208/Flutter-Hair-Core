import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Models/products.dart';
import 'package:hair_cos/Products/addProduct.dart';
import 'package:hair_cos/Products/cart.dart';
import 'package:hair_cos/Products/product_details.dart';
import 'package:intl/intl.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var day = DateTime.now();
  var newDay;
  var formatter;
  String formatedDay, formatedMonth;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      newDay = day.add(Duration(days: 3));
    });
    print(newDay.day);
    formatter = new DateFormat('EEEE');
    formatedDay = formatter.format(newDay);
    formatter = new DateFormat('MMMM');
    formatedMonth = formatter.format(newDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddProduct())),
        heroTag: null,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        //  leading: IconButton(icon: Icon(Icons.add), onPressed: ),
        title: Text('Products'),
        bottom: PreferredSize(
            child: Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 9,
                padding: EdgeInsets.only(left: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Text(
                        index == 0
                            ? 'All'
                            : index == 1
                                ? 'Combs'
                                : index == 2
                                    ? 'Scissors'
                                    : index == 3 ? 'Hair Gel' : 'Hair Spray',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                selected == index ? FontWeight.bold : null,
                            color: selected == index ? Colors.red : null),
                      ),
                    ),
                  );
                },
              ),
            ),
            preferredSize: Size.fromHeight(40)),

        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
                  child: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart())),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )),
              Positioned(
                left: 20,
                top: 8,
                child: Product.productData.cart.length != 0
                    ? CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          "${Product.productData.cart.length}",
                          style: TextStyle(fontSize: 10),
                        ),
                        radius: 7,
                      )
                    : Container(),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => imageCard(index)),
            ),
          ],
        ),
      ),

      /* StreamBuilder(
        stream: Firestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    imageCard(snapshot.data.documents[index], index));
          }
        },
      ), */
    );
  }

  /* imageCard(DocumentSnapshot data, int index) {
    print(data['photo'][0]);
    return GestureDetector(
      onTap: () {
        setState(() {
          Product.productData.title = data['title'];
          Product.productData.description = data['description'];
          Product.productData.pictures = data['photo'];
          Product.productData.price = data['price'];
          Product.productData.instock = data['stock'];
          Product.productData..docid = data.documentID;
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductDeatils()));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.width / 2,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: data['photo'] != null || data['photo'] != ""
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(5),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(),
                              width: 50.0,
                              height: 50.0,
                              padding: EdgeInsets.all(15.0),
                            ),
                            imageUrl: "${data['photo'][0]}",
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
                        '${data['title']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${data['description']}',
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
                            '${data['price']}',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.check,
                            color: Colors.yellow,
                          ),
                          Text(
                            'Prime',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(' get it'),
                          Text(
                            '  $formatedDay, $formatedMonth, ${newDay.day}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(' Eligible for FREE UK Delievery ')
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
 */

  imageCard(int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductDeatils())),
      child: Card(
        elevation: 10,
        child: Container(
            padding: EdgeInsets.only(right: 5),
            height: MediaQuery.of(context).size.width / 2.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Image.asset('assets/images/scissor.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Y.S. Park YS-254 Bar',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            Text(
                              'Barbar Comb ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_half,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                Text(' 4.9'),
                                Text(
                                  ' (148 ratings)',
                                  style: TextStyle(color: Colors.grey[400]),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: null,
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                      color: secondaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '\$ 966',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '\$1096',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          '9% OFF',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(''),
                      ],
                    )),
                Flexible(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    'Etiam viverra sed lectus sed fringilla. Suspendisse ante justo, tempor eget sodales sed, rutrum vitae justo. Nulla luctus, sem in tincidunt vehicula, lectus purus dapibus sem, a efficitur tellus erat non risus. Nam porttitor in libero in dapibus. Suspendisse sed ex ut diam sodales accumsan vitae nec leo. Ut interdum commodo felis non convallis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In varius sem enim, ut blandit arcu lobortis sit amet. Aenean hendrerit pharetra nulla, a volutpat nibh bibendum ac. Sed et egestas nisl.',
                    maxLines: 2,
                    style: TextStyle(height: 1.4),
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
