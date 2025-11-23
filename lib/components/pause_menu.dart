import 'package:flutter/material.dart';
import 'package:mp5/colors/colors.dart';
import 'package:mp5/components/large_label.dart';
import 'package:mp5/components/round_button.dart';
import 'package:mp5/pages/game_page.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: .center,
      backgroundColor: GlassGameColors.DIALOG_BG,
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(20))),
      content: Column(
        children: [
          Spacer(),
          StrokedLabel(label: "Paused"),
          Spacer(),
          Row(
            mainAxisAlignment: .center,
            children: [
              RoundButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icons.arrow_back,
              ),
              RoundButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GamePage();
                      },
                    ),
                  );
                },
                icon: Icons.replay,
              ),
              RoundButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icons.play_arrow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// comment to avoid errors
