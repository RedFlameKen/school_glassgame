import 'package:flutter/material.dart';
import 'package:mp5/colors/colors.dart';

class RoundButton extends StatelessWidget {
  final Function() onPressed;
  final Widget icon;
  const RoundButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      padding: .all(15),
      elevation: 2,
      shape: CircleBorder(),
      fillColor: GlassGameColors.BUTTON_BACKGROUND,
      child: icon,
    );
  }
}
