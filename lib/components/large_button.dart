import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Function() onPressed;

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size size;
  final double borderSize;
  final Color borderColor;

  const LargeButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = Colors.lightBlue,
    this.foregroundColor = Colors.white,
    this.size = const Size(200, 80),
    this.borderSize = 5,
    this.borderColor = Colors.grey
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
      child: Text(label),
    );
  }
}

