import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/CustomViews/CustomButton.dart';

class DrawerFull extends PreferredSize {
  DrawerFull(BuildContext context, Size size)
      : super(
            preferredSize: Size.fromHeight(0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.8),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: size.height / 10,
                      left: size.width / 18,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryColor),
                          child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () => Navigator.pop(context))),
                    ),
                    Positioned(
                      top: size.height / 6,
                      left: size.width / 8,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: size.height / 1.7,
                        width: size.width / 1.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    child: Image.asset(
                                      'assets/images/pPhoto.png',
                                    ),
                                  ),
                                  title: Text('Jonerson Doe'),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    'assets/images/profile.png',
                                    height: 25,
                                    width: 25,
                                    color: secondaryColor,
                                  ),
                                  title: Text(
                                    'My Profile',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    'assets/images/ticket.png',
                                    height: 25,
                                    width: 25,
                                    color: secondaryColor,
                                  ),
                                  title: Text(
                                    'My History',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    'assets/images/star.png',
                                    height: 30,
                                    width: 30,
                                    color: secondaryColor,
                                  ),
                                  title: Text(
                                    'Feedback',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    'assets/images/info.png',
                                    height: 25,
                                    width: 25,
                                    color: secondaryColor,
                                  ),
                                  title: Text(
                                    'About Us',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: 30,
                                width: 100,
                                child: CustomButton.roundedButton(context,
                                    txt: 'Logout',
                                    fontsize: 14.0,
                                    bold: false,
                                    background: secondaryColor,
                                    textColor: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
}

Widget imageSvg(String path) {
  return SvgPicture.asset(
    path,
    height: 25,
    width: 25,
  );
}
