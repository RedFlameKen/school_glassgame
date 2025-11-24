import 'package:flutter/material.dart';
import 'package:glassgame/colors/colors.dart';
import 'package:glassgame/components/large_label.dart';
import 'package:glassgame/components/round_button.dart';

class HelpMenu extends StatelessWidget {
  static const String MECHANICS_HELP_MESSAGE =
      "Pour water from one glass to another until the first glass has no water, the second glass has 4 ounces, and the third glass has 4 ounces. Pouring will transfer all water from the pouring glass to the receiving glass until the receiving glass is full. In which case, any remaining water will stay in the pouring glass.";
  static const String DRAG_HELP_MESSAGE =
      "Dragging a glass on top of another will pour water into the hovered glass.";
  static const String TAP_HELP_MESSAGE =
      "Double tapping on a glass will mark it as a glass to pour. Tapping another glass will receive the poured water.";

  const HelpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: .center,
      backgroundColor: GlassGameColors.DIALOG_BG,
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(20))),
      content: Column(
        mainAxisSize: .min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: .vertical,
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                children: [
                  Align(
                    alignment: .center,
                    child: StrokedLabel(label: "Mechanics"),
                  ),
                  StrokedLabel(label: MECHANICS_HELP_MESSAGE, fontSize: 18),
                  Padding(
                    padding: .only(top: 20),
                    child: Align(
                      alignment: .center,
                      child: StrokedLabel(label: "Controls"),
                    ),
                  ),
                  Padding(
                    padding: .only(bottom: 20),
                    child: StrokedLabel(label: DRAG_HELP_MESSAGE, fontSize: 18),
                  ),
                  StrokedLabel(label: TAP_HELP_MESSAGE, fontSize: 18),
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: .only(top: 15),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  RoundButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icons.close,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// comment to avoid errors
