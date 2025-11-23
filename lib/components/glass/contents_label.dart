import 'package:flutter/material.dart';

class ContentsLabel extends StatelessWidget {
  final String label;
  final double fontSize = 35;
  const ContentsLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = .stroke
              ..strokeWidth = 2
              ..color = Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ],
    );
  }
}
