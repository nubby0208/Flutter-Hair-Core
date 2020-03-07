import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Models/products.dart';
import 'package:hair_cos/Products/addProduct.dart';
import 'package:hair_cos/Products/cart.dart';
import 'package:hair_cos/Products/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddProduct())),
        heroTag: null,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        //  leading: IconButton(icon: Icon(Icons.add), onPressed: ),
        title: Text('Products'),
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
      body: StreamBuilder(
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
      ),
    );
  }

  imageCard(DocumentSnapshot data, int index) {
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
          height: MediaQuery.of(context).size.width / 2.5,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
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
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
