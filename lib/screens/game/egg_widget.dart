import 'package:flutter/material.dart';
import 'package:chicken_game/screens/game/game_models.dart';

class EggWidget extends StatelessWidget {
  final Egg egg;
  final String eggSkinPath;

  const EggWidget({super.key, required this.egg, required this.eggSkinPath});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(
      left: egg.x * screenSize.width - 25,
      top: egg.y * screenSize.height,
      child: Image.asset(eggSkinPath, width: 50, height: 50),
    );
  }
}
