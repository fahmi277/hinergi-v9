import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatelessWidget {
  final String nama;
  final String password;
  final String labelText;
  final String hintText;
  final Icon icon;
  final TextInputType textInputType;
  final String value;
  final Function validator;
  final Function onSaved;
  final int maxLength;

  MyTextFormField(
      {this.nama,
      this.password,
      this.hintText,
      this.labelText,
      this.icon,
      this.textInputType,
      this.onSaved,
      this.value,
      this.validator,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    _controller.text = value;
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
          left: ScreenUtil().setWidth(50),
          right: ScreenUtil().setWidth(50)),
      child: TextFormField(
        controller:_controller,
        maxLength: maxLength,
        validator: validator,
        autofocus: true,
        keyboardType: textInputType,
        onSaved: onSaved,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 4, 117, 116)),
            ),
            focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 4, 117, 116)),
            ),
            icon: icon,
            labelText: labelText,
            hintText: hintText),
      ),
    );
  }
}
