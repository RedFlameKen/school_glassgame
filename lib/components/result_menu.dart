import 'package:flutter/material.dart';
import 'package:mp5/colors/colors.dart';
import 'package:mp5/components/large_label.dart';
import 'package:mp5/components/round_button.dart';

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
                icon: Icons.arrow_back,
              ),
              RoundButton(
                onPressed: () => Navigator.pop(context, true),
                icon: Icons.replay,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// comment to avoid errors
