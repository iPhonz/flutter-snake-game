import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'components.dart';
import 'constants.dart';

class GameLogic extends ChangeNotifier {
  late List<Position> snake;
  late Position food;
  late Direction direction;
  late Timer timer;
  int score = 0;
  bool isGameOver = false;

  GameLogic() {
    resetGame();
  }

  void resetGame() {
    snake = [
      Position(x: GRID_SIZE ~/ 2, y: GRID_SIZE ~/ 2),
    ];
    direction = Direction.right;
    generateFood();
    score = 0;
    isGameOver = false;

    timer?.cancel();

    timer = Timer.periodic(const Duration(milliseconds: 200), (Timer timer) {
      update();
    });
    notifyListeners();
  }

  void generateFood() {
    final random = Random();
    do {
      food = Position(
        x: random.nextInt(GRID_SIZE),
        y: random.nextInt(GRID_SIZE),
      );
    } while (snake.contains(food));
  }

  void update() {
    if (isGameOver) return;

    Position newHead = Position(
      x: snake.first.x,
      y: snake.first.y,
    );

    switch (direction) {
      case Direction.up:
        newHead.y--;
        break;
      case Direction.down:
        newHead.y++;
        break;
      case Direction.left:
        newHead.x--;
        break;
      case Direction.right:
        newHead.x++;
        break;
    }

    if (newHead.x < 0 ||
        newHead.x >= GRID_SIZE ||
        newHead.y < 0 ||
        newHead.y >= GRID_SIZE ||
        snake.contains(newHead)) {
      isGameOver = true;
      timer.cancel();
      notifyListeners();
      return;
    }

    snake.insert(0, newHead);

    if (newHead.x == food.x && newHead.y == food.y) {
      score++;
      generateFood();
    } else {
      snake.removeLast();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}