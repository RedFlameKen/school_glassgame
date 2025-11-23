import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp5/components/background/game_background.dart';
import 'package:mp5/components/large_button.dart';
import 'package:mp5/pages/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildHomePage(BuildContext context, bool isPortrait) {
    return Expanded(
      child: Stack(
        children: [
          GameBackground(),
          isPortrait ? _buildPortrait(context) : _buildLandscape(context),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: .only(left: 50, right: 50),
                child: Image.asset(
                  "assets/images/glass_game_title.png",
                  fit: .fitWidth,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: .spaceAround,
            children: [
              Spacer(),
              Center(
                child: Padding(
                  padding: .all(15),
                  child: LargeButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const GamePage();
                          },
                        ),
                      );
                    },
                    label: "Play",
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: .all(15),
                  child: LargeButton(onPressed: () => exit(0), label: "Exit"),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: .only(left: 50, right: 50),
          child: Image.asset("assets/images/glass_game_title.png", fit: .fill),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: .spaceAround,
          children: [
            Center(
              child: Padding(
                padding: .all(15),
                child: LargeButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const GamePage();
                        },
                      ),
                    );
                  },
                  label: "Play",
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: .all(15),
                child: LargeButton(onPressed: () => exit(0), label: "Exit"),
              ),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(.immersiveSticky, overlays: [.top]);
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return _buildHomePage(context, orientation == Orientation.portrait);
        },
      ),
    );
  }
}
