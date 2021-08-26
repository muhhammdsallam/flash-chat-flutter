import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Color color;
  final Function onPressed;
  final Color textColor;
  final Color borderColor;
  ButtonWidget(
      {this.label,
      this.color,
      @required this.onPressed,
      this.textColor,
      this.borderColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 0,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: borderColor)),
          onPressed: onPressed,
          minWidth: 200.0,
          height: 53.0,
          child: Text(
            label,
            style: TextStyle(color: textColor, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
