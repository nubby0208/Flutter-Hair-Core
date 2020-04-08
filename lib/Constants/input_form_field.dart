import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';

class FormFeild extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType inputType;
  final bool obsecure;
  const FormFeild(
      {@required this.userPassword,
      this.hint,
      this.icon,
      this.label,
      @required this.obsecure,
      this.inputType});

  final TextEditingController userPassword;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      //margin: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: icon == null ? EdgeInsets.only(left: 20) : null,
        child: TextFormField(
          controller: userPassword,
          keyboardType: inputType != null ? inputType : null,
          obscureText: obsecure,
          decoration: InputDecoration(
              labelText: label != null ? label : null,
              hintText: hint,
              prefixIcon:
                  icon != null ? Icon(icon, color: secondaryColor) : null,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
