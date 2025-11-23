import 'package:flutter/material.dart';
import 'package:mp5/components/background/game_background.dart';
import 'package:mp5/components/glass/glass.dart';
import 'package:mp5/components/background/table_background.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  final List<Glass> _glasses = [
    Glass(size: 3),
    Glass(size: 5),
    Glass(size: 8, contents: 8),
  ];

  Widget _buildGlassesRow() {
    return Row(
      crossAxisAlignment: .end,
      mainAxisAlignment: .center,
      children: [
        _buildDraggableGlasses(_glasses[0]),
        _buildDraggableGlasses(_glasses[1]),
        _buildDraggableGlasses(_glasses[2]),
      ],
    );
  }

  Widget _buildDragTargetGlass(Glass glass) {
    return DragTarget<Glass>(
      builder: (context, candidateItems, rejectedItems) {
        return Container(
          decoration: BoxDecoration(
            color: candidateItems.isNotEmpty
                ? Colors.yellow
                : Colors.transparent,
          ),
          child: Visibility.maintain(
            visible: !glass.isDragged,
            child: GlassWidget(glass: glass),
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
        setState(() {
          details.data.pour(glass);
        });
      },
    );
  }

  Widget _buildDraggableGlasses(Glass glass) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          LongPressDraggable<Glass>(
            data: glass,
            maxSimultaneousDrags: 1,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: GlassWidget(glass: glass),
            child: _buildDragTargetGlass(glass),
            onDragStarted: () {
              setState(() {
                glass.isDragged = true;
              });
            },
            onDragEnd: (details) {
              setState(() {
                glass.isDragged = false;
              });
            },
          ),
          Text("${glass.contents}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, bottomOpacity: 0),
      body: Stack(
        children: [
          GameBackground(),
          TableBackground(),
          Column(children: [Spacer(), _buildGlassesRow(), Spacer()]),
        ],
      ),
    );
  }
}
