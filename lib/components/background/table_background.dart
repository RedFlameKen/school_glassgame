import 'package:flutter/material.dart';

class TableBackground extends StatelessWidget {
  const TableBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .bottomCenter,
      child: Image.asset(
        "assets/images/cartoon_table.png",
        height: MediaQuery.of(context).size.height * 0.5,
        fit: .fitHeight,
      ),
    );
  }
}
