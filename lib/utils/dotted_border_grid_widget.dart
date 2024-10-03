import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DottedBorderGridWidget extends StatelessWidget {
  const DottedBorderGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;

    int getCrossAxisCount(double width) {
      if (width >= 1200) {
        return 12; // For very large screens
      } else if (width >= 800) {
        return 8; // For medium to large screens
      } else if (width >= 600) {
        return 6; // For small to medium screens
      } else {
        return 5; // For mobile and very small screens
      }
    }

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: StaggeredGrid.count(
            crossAxisCount: getCrossAxisCount(screenWidth),
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            children: [
              ...List.generate(200, (index) {
                return CustomPaint(
                  size: Size(100, 100),
                  painter: DottedBorderPainter(space: 12),
                  child: SizedBox(
                    height: 200,
                    width: 100,
                  ),
                );
              })
            ]),
      ),
    );
  }
}

class CustomDottedBorder extends StatelessWidget {
  final double width;
  final double height;
  final double space; // Add spacing parameter

  const CustomDottedBorder({
    Key? key,
    required this.width,
    required this.height,
    this.space = 10.0, // Default space value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: DottedBorderPainter(space: space),
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final double space;

  DottedBorderPainter({required this.space});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = darkDividerColor // Set your desired color
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // Draw right side border (vertical line)
    drawDottedLine(
      canvas,
      paint,
      Offset(size.width, space), // Start at top right with space
      Offset(size.width, size.height), // End at bottom right
    );

    // Draw bottom side border (horizontal line)
    drawDottedLine(
      canvas,
      paint,
      Offset(space, size.height), // Start at bottom left with space
      Offset(size.width, size.height), // End at bottom right
    );
  }

  void drawDottedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    final dashWidth = 10.0; // Width of the dashes
    final dashSpace = 8.0; // Space between dashes
    final totalLength = (end - start).distance; // Total length of the line
    final dashCount =
        (totalLength / (dashWidth + dashSpace)).floor(); // Number of dashes

    for (int i = 0; i < dashCount; i++) {
      final dx = start.dx +
          (i * (dashWidth + dashSpace)) * ((end.dx - start.dx) / totalLength);
      final dy = start.dy +
          (i * (dashWidth + dashSpace)) * ((end.dy - start.dy) / totalLength);
      canvas.drawLine(
        Offset(dx, dy),
        Offset(dx + dashWidth * ((end.dx - start.dx) / totalLength),
            dy + dashWidth * ((end.dy - start.dy) / totalLength)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
