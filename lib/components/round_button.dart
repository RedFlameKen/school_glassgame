import 'package:flutter/material.dart';
import 'package:mp5/colors/colors.dart';

class RoundButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final double size;
  const RoundButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 35,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon, color: GlassGameColors.BUTTON_FG, size: size),
      style: ButtonStyle(
        elevation: .all(2),
        shadowColor: .all(Colors.black),
        backgroundColor: .all(GlassGameColors.BUTTON_BG),
      ),
    );
  }
}
