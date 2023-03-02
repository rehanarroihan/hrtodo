import 'package:flutter/material.dart';

enum ButtonStyle {
  text,
  outlined,
  filled,
  elevated
}

class Button extends StatelessWidget {
  final ButtonStyle style;
  final String label;
  final VoidCallback onPressed;
  final bool disabled;
  final double fontSize;
  final double verticalPadding;
  final FontWeight fontWeight;

  const Button({
    Key? key,
    this.style = ButtonStyle.elevated,
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.fontSize = 18,
    this.verticalPadding = 12,
    this.fontWeight = FontWeight.w500
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (style == ButtonStyle.text) {
      return TextButton(
        onPressed: !disabled ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight
            ),
          ),
        ),
      );
    } else if (style == ButtonStyle.outlined) {
      return OutlinedButton(
        onPressed: !disabled ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight
            ),
          ),
        ),
      );
    } else if (style == ButtonStyle.filled) {
      return FilledButton(
        onPressed: !disabled ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight
            ),
          ),
        ),
      );
    }
  }
}
