import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static Widget roundedButton(
    context, {
    txt,
    background,
    textColor,
    onPress,
    borderColor,
    bold,
    fontsize,
  }) {
    Color bgColor = Theme.of(context).primaryColor;
    Color txtColor = Colors.white;
    return RaisedButton(
      onPressed: () {
        if (onPress != null) onPress();
      },
      color: background ?? bgColor,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: borderColor ?? (background ?? bgColor),
          width: 3,
        ),
      ),
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                color: textColor ?? txtColor,
                fontSize: fontsize != null ? fontsize : 20,
                fontWeight: bold == null ? FontWeight.bold : null),
          ),
        ),
      ),
    );
  }
}
