import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final int lines;
  final FormValidator validator;

  const CustomTextField(
      {Key key,
      this.textEditingController,
      this.hintText,
      this.isPassword = false,
      this.lines = 1,
      this.labelText,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        maxLines: lines,
        obscureText: isPassword,
        controller: textEditingController,
      ),
    );
  }
}
