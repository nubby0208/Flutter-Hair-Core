import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';

class FormFeild extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType inputType;
  final bool obsecure;
  final Function onChanged;
  final TextEditingController controller;

  const FormFeild({
    this.hint,
    this.icon,
    this.label,
    @required this.obsecure,
    this.inputType,
    this.onChanged,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      //margin: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: TextFormField(
          controller: controller,
          keyboardType: inputType != null ? inputType : null,
          obscureText: obsecure,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(icon, color: secondaryColor),
            border: InputBorder.none,
          ),
          onChanged: (val) => onChanged(val) ?? {},
        ),
      ),
    );
  }
}
