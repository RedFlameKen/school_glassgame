import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp5/components/background/game_background.dart';
import 'package:mp5/components/glass/contents_label.dart';
import 'package:mp5/components/glass/glass.dart';
import 'package:mp5/components/background/table_background.dart';
import 'package:mp5/components/help_menu.dart';
import 'package:mp5/components/large_label.dart';
import 'package:mp5/components/pause_menu.dart';
import 'package:mp5/components/result_menu.dart';
import 'package:mp5/components/round_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  int _moveCount = 0;
  Glass? _heldGlass;

  final List<Glass> _glasses = [
    Glass(size: 3),
    Glass(size: 5),
    Glass(size: 8, contents: 8),
  ];

  void incrementMoves() {
    setState(() {
      _moveCount++;
    });
  }

  void restartGame() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GamePage()),
    );
  }

  void backToHome() {
    Navigator.pop(context);
  }

  void checkGameWin() async {
    if (_glasses[0].contents == 0 &&
        _glasses[1].contents == 4 &&
        _glasses[2].contents == 4) {
      bool restart = await showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (context) {
          return ResultMenu(moves: _moveCount);
        },
      );
      if (restart) {
        restartGame();
        return;
      }
      backToHome();
    }
  }

  Widget _buildGlassesRow() {
    return Row(
      crossAxisAlignment: .end,
      mainAxisAlignment: .center,
      children: [
        Flexible(child: _buildDraggableGlasses(_glasses[0])),
        Flexible(child: _buildDraggableGlasses(_glasses[1])),
        Flexible(child: _buildDraggableGlasses(_glasses[2])),
      ],
    );
  }

  bool _shouldHighlightGlass(bool noCandidates, Glass glass) {
    return (_heldGlass != null && _heldGlass == glass) || !noCandidates;
  }

  void _pourEvent(Glass pourGlass, Glass glass) {
    setState(() {
      pourGlass.pour(glass);
      incrementMoves();
      checkGameWin();
    });
  }

  Widget _buildDragTargetGlass(Glass glass) {
    return DragTarget<Glass>(
      builder: (context, candidateItems, rejectedItems) {
        return GestureDetector(
          onDoubleTap: () {
            setState(() {
              _heldGlass = glass;
            });
          },
          onTap: () {
            if (_heldGlass != null) {
              if (_heldGlass == glass) {
                setState(() {
                  _heldGlass = null;
                });
                return;
              }
              setState(() {
                _pourEvent(_heldGlass!, glass);
                _heldGlass = null;
              });
              return;
            }
          },
          child: ClipRRect(
            borderRadius: .only(
              bottomLeft: .circular(10),
              bottomRight: .circular(10),
            ),
            child: ColorFiltered(
              colorFilter: _shouldHighlightGlass(candidateItems.isEmpty, glass)
                  ? .mode(Colors.white, .softLight)
                  : .mode(Colors.transparent, .screen),
              child: Visibility.maintain(
                visible: !glass.isDragged,
                child: GlassWidget(glass: glass),
              ),
            ),
          ),
        );
      },
      onWillAcceptWithDetails: (details) {
        if (details.data == glass) {
          return false;
        }
        return true;
      },
      onAcceptWithDetails: (details) {
        _pourEvent(details.data, glass);
      },
    );
  }

  Widget _buildDraggableGlasses(Glass glass) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Draggable<Glass>(
            data: glass,
            feedback: GlassWidget(glass: glass),
            child: _buildDragTargetGlass(glass),
            onDragStarted: () {
              setState(() {
                glass.isDragged = true;
                _heldGlass = null;
              });
            },
            onDragEnd: (details) {
              setState(() {
                glass.isDragged = false;
              });
            },
          ),
          ContentsLabel(label: "${glass.contents}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GameBackground(),
          TableBackground(),
          Column(
            children: [
              Row(
                crossAxisAlignment: .center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StrokedLabel(label: "Moves: $_moveCount"),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        builder: (context) {
                          return HelpMenu();
                        },
                      );
                    },
                    icon: Icon(Icons.help_outline, color: Colors.white,),
                    iconSize: 40,
                  ),
                  RoundButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PauseMenu();
                        },
                        useSafeArea: true,
                        barrierDismissible: false,
                      );
                    },
                    icon: Icons.pause,
                  ),
                ],
              ),
              Spacer(),
              _buildGlassesRow(),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
