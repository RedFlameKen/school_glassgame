import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mp5/components/background/game_background.dart';
import 'package:mp5/components/large_button.dart';
import 'package:mp5/pages/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Stack(
          children: [
            GameBackground(),
            Column(
              children: [
                Spacer(),
                Padding(
                  padding: .only(left: 50, right: 50),
                  child: Image.asset(
                    "assets/images/glass_game_title.png",
                    fit: .fill,
                  ),
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
                        child: LargeButton(
                          onPressed: () => exit(0),
                          label: "Exit",
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
