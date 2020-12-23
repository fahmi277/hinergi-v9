library dropdown_formfield;

import 'package:flutter/material.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final EdgeInsets contentPadding;
  final Icon icon;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select Unit',
      this.required = false,
      this.errorText = 'Select Unit',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged,
      this.filled = true,
      this.icon,
      this.contentPadding = const EdgeInsets.fromLTRB(12, 12, 8, 0)})
      : super(
          onSaved: onSaved,
          validator: validator,
          // autovalidate: autovalidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                       icon: icon,
                      // labelText: titleText,
                      // filled: filled,
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        // borderSide: BorderSide(color: Color(0xFF6200EE)),
                        borderSide: BorderSide(color: Colors.grey[200], width: 2),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        value: value == '' ? null : value,
                        onChanged: (dynamic newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item[valueField],
                            child: Text(item[textField],
                                overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}