import 'package:flutter/material.dart';

class GlassWidget extends StatefulWidget {
  final Glass glass;
  const GlassWidget({super.key, required this.glass});

  @override
  State<StatefulWidget> createState() => _GlassWidgetState();
}

class _GlassWidgetState extends State<GlassWidget> with TickerProviderStateMixin {
  final double heightFactor = 20;
  final double widthFactor = 20;
  final double largestGlassWidth = 115;

  double getGlassWidth() {
    if (widget.glass.size == 8) {
      return largestGlassWidth;
    }
    return (widget.glass.size * widthFactor);
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        height: getGlassWidth(),
        width: widget.glass.size * heightFactor,
        decoration: BoxDecoration(
          borderRadius: .only(
            bottomLeft: .circular(10),
            topLeft: .circular(10),
          ),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 5,
            right: 2,
          ),
          child: LinearProgressIndicator(
            color: Colors.lightBlue,
            backgroundColor: Colors.grey,
            value: widget.glass.contents / widget.glass.size,
            minHeight: 50,
            borderRadius: .only(
              bottomLeft: .circular(10),
              topLeft: .circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class Glass {
  final int size;
  bool isDragged = false;
  int contents;

  Glass({required this.size, this.contents = 0});

  int getOverflow(int amount) {
    return (contents + amount) - size;
  }

  int fill(int amount) {
    int overflow = 0;
    if (contents + amount > size) {
      overflow = getOverflow(amount);
    }

    if (overflow > 0) {
      contents = size;
      debugPrint("filled with overflow $contents");
      return overflow;
    }

    contents += amount;
    debugPrint("filled $contents");
    return overflow;
  }

  bool pour(Glass rGlass) {
    if (contents <= 0) {
      return false;
    }
    contents = rGlass.fill(contents);
    debugPrint("poured ${rGlass.contents}");
    return true;
  }
}

// comment to avoid lsp errors
