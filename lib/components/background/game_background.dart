import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/blurred_kitchen_background2.png",
      fit: .fitHeight,
      height: MediaQuery.of(context).size.height,
      alignment: .xy(-0.3, 0),
    );
  }
}
