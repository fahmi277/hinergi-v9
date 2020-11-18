import 'package:flutter/material.dart';


class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String helpText;
  final String value;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final Icon icon;
  
MyTextFormField({
    this.hintText,
    this.labelText,
    this.helpText,
    this.value = '0',
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.icon
  });
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    _controller.text = value;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller:_controller,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          labelText: labelText,
          helperText: helpText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          // filled: true,
          // fillColor: Colors.grey[200],
          enabledBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Color(0xFF6200EE)),
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
          ),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
