import 'package:flutter/material.dart';

class StrokedLabel extends StatelessWidget {
  final String label;
  final double fontSize;
  const StrokedLabel({super.key, required this.label, this.fontSize = 30});

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
