import 'package:flutter/material.dart';
import 'package:glassgame/colors/colors.dart';
import 'package:glassgame/components/large_label.dart';
import 'package:glassgame/components/round_button.dart';

class ResultMenu extends StatelessWidget {
  final String WIN_MESSAGE = "Puzzle Solved";
  final int moves;

  const ResultMenu({super.key, required this.moves});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: GlassGameColors.DIALOG_BG,
      alignment: .center,
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(20))),
      content: Column(
        mainAxisSize: .min,
        children: [
          Flexible(
            child: Column(
              children: [
                StrokedLabel(label: WIN_MESSAGE),
                Spacer(),
                StrokedLabel(label: "Total Moves"),
                StrokedLabel(label: "$moves"),
                Spacer(),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              mainAxisSize: .max,
              children: [
                RoundButton(
                  onPressed: () => Navigator.pop(context, false),
                  icon: Icons.arrow_back,
                ),
                RoundButton(
                  onPressed: () => Navigator.pop(context, true),
                  icon: Icons.replay,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// comment to avoid errors
