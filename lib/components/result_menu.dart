import 'package:flutter/material.dart';
import 'package:mp5/components/large_label.dart';
import 'package:mp5/components/round_button.dart';

class ResultMenu extends StatelessWidget {
  final String WIN_MESSAGE = "Puzzle Solved";
  final int moves;

  const ResultMenu({super.key, required this.moves});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: .center,
      insetPadding: .only(top: 150, bottom: 150),
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(20))),
      content: Container(
        child: Column(
          children: [
            StrokedLabel(label: WIN_MESSAGE),
            Spacer(),
            StrokedLabel(label: "Total Moves"),
            StrokedLabel(label: "$moves"),
            Spacer(),
            Row(
              mainAxisAlignment: .center,
              children: [
                RoundButton(
                  onPressed: () => Navigator.pop(context, false),
                  icon: Icon(Icons.arrow_back, size: 35),
                ),
                RoundButton(
                  onPressed: () => Navigator.pop(context, true),
                  icon: Icon(Icons.replay, size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// comment to avoid errors
