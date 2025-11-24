import 'package:flutter/material.dart';
import 'package:glassgame/components/background/game_background.dart';
import 'package:glassgame/components/glass/contents_label.dart';
import 'package:glassgame/components/glass/glass.dart';
import 'package:glassgame/components/background/table_background.dart';
import 'package:glassgame/components/help_menu.dart';
import 'package:glassgame/components/large_label.dart';
import 'package:glassgame/components/pause_menu.dart';
import 'package:glassgame/components/result_menu.dart';
import 'package:glassgame/components/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState(){
    super.initState();
    _checkHelpShown();
  }

  void _checkHelpShown() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {"helpShown"}
      ),
    );

    if(prefs.containsKey("helpShown")){
      bool helpShown = prefs.getBool("helpShown")!;
      if(!helpShown){
        _showHelpDialog();
      }
      return;
    }
    await prefs.setBool("helpShown", true);
    _showHelpDialog();
  }

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
      mainAxisAlignment: .spaceAround,
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
    return Column(
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
    );
  }

   Future<T?> _showHelpDialog<T>() async {
    return showDialog<T>(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return HelpMenu();
      },
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
                      _showHelpDialog();
                    },
                    icon: Icon(Icons.help_outline, color: Colors.white),
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
