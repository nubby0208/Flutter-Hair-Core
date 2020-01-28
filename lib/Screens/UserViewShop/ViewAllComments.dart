import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/CustomViews/CommentView.dart';

class ViewAllComments extends StatefulWidget {
  _ViewAllComments createState() => _ViewAllComments();
}

class _ViewAllComments extends State<ViewAllComments> {
  final profileImages = [
    "asserts/barber_pic_1.jpg",
    "asserts/barber_pic_2.jpg",
    "asserts/barber_pic_3.jpg"
  ];
  final names = ['Zic Kine', 'Ken Neddy', 'Caleb McKayler'];
  final ratings = [3, 2, 5];
  final comments = [
    "Best barber in the whole area, went today and even gave me a discount",
    "Best barber in the whole area, went today and even gave me a discount, today he came up to"
        "me and gave me the most insane trim of my life so im definetly going back after a few"
        "months",
    "Best barber in the whole area, went today and even gave me a discount"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Comments"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          )),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: CommentView(
                  image: profileImages[index],
                  name: names[index],
                  rating: ratings[index],
                  text: comments[index],
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.black, indent: 50,);
          },
          itemCount: profileImages.length),
    );
  }
}
