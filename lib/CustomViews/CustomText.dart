import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText{
  static decoratedText({name, hint, borderColor, controller}){
    return TextFormField(
      controller: controller ?? TextEditingController(),
      decoration: InputDecoration(
        labelText: name,
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.blue),
        ),
      ),
    );
  }
}
