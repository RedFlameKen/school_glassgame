import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class TableBackground extends StatelessWidget {
  const TableBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: .translation(Vector3(0, 40, 0)),
      child: Align(
        alignment: .bottomCenter,
        child: Image.asset(
          "assets/images/cartoon_table.png",
          height: MediaQuery.of(context).size.height * 0.5,
          fit: .fitHeight,
        ),
      ),
    );
  }
}
