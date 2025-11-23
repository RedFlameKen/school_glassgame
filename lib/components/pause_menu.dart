import 'package:flutter/material.dart';
import 'package:mp5/components/large_label.dart';
import 'package:mp5/components/round_button.dart';
import 'package:mp5/pages/game_page.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: .center,
      insetPadding: .only(top: 150, bottom: 150),
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(20))),
      content: Container(
        child: Column(
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
                  icon: Icon(Icons.arrow_back, size: 35),
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
                  icon: Icon(Icons.replay, size: 35),
                ),
                RoundButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.play_arrow, size: 35),
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
