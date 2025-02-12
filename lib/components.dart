import 'package:flutter/material.dart';
import 'constants.dart';

class Position {
  int x;
  int y;

  Position({required this.x, required this.y});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class GamePainter extends CustomPainter {
  final List<Position> snake;
  final Position food;

  GamePainter({required this.snake, required this.food});

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / GRID_SIZE;

    // Draw snake
    final snakePaint = Paint()..color = Colors.green;
    for (var pos in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          pos.x * cellSize,
          pos.y * cellSize,
          cellSize - 1,
          cellSize - 1,
        ),
        snakePaint,
      );
    }

    // Draw food
    final foodPaint = Paint()..color = Colors.red;
    canvas.drawCircle(
      Offset(
        food.x * cellSize + cellSize / 2,
        food.y * cellSize + cellSize / 2,
      ),
      cellSize / 3,
      foodPaint,
    );
  }

  @override
  bool shouldRepaint(GamePainter oldDelegate) =>
      snake != oldDelegate.snake || food != oldDelegate.food;
}