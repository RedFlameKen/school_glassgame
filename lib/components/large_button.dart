import 'package:flutter/material.dart';
import 'package:mp5/colors/colors.dart';

class LargeButton extends StatelessWidget {
  final Function() onPressed;

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size size;
  final double borderSize;
  final double fontSize;
  final Color borderColor;

  const LargeButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = GlassGameColors.BUTTON_BG,
    this.foregroundColor = GlassGameColors.BUTTON_FG,
    this.size = const Size(200, 80),
    this.borderSize = 5,
    this.fontSize = 25,
    this.borderColor = GlassGameColors.GLASS,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: size,
        maximumSize: size,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: BorderSide(width: borderSize, color: borderColor)
      ),
      onPressed: onPressed,
      child: Text(label,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }
}

