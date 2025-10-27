import 'package:flutter/material.dart';

enum GameStatus { playing, paused, won, lost }

class Egg {
  final String id;
  double x;
  double y;
  final Key key;

  Egg({required this.x, required this.y, required this.id}) : key = UniqueKey();
}
