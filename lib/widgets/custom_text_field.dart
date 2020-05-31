import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final int lines;
  final FormValidator validator;
  final void Function(String) onChanged;

  const CustomTextField({
    Key key,
    this.textEditingController,
    this.hintText,
    this.isPassword = false,
    this.lines = 1,
    this.labelText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        counterText: ' ',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      maxLines: lines,
      obscureText: isPassword,
      controller: textEditingController,
    );
  }
}
