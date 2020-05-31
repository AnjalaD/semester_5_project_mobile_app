import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.labelText,
    @required this.onPressed,
    this.color,
  }) : super(key: key);

  final Color color;
  final String labelText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      minWidth: 200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: RaisedButton(
        color: color,
        onPressed: onPressed,
        child: Text(labelText),
        textColor: Colors.white,
      ),
    );
  }
}
