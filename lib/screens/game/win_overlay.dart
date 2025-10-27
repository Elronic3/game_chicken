import 'package:flutter/material.dart';
import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/screens/game/game_overlay_widgets.dart';
import 'package:go_router/go_router.dart';

class WinOverlay extends StatelessWidget {
  final int levelNumber;
  final int totalLevels;
  final int score;
  final int bestScore;
  // final VoidCallback onNextLevel;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  const WinOverlay({
    super.key,
    required this.levelNumber,
    required this.totalLevels,
    required this.score,
    required this.bestScore,
    // required this.onNextLevel,
    required this.onRestart,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLastLevel = (levelNumber == totalLevels);

    return GameOverlayBase(
      children: [
        Text(
          'YOU WIN!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ScoreDisplay(label: 'SCORE', value: score),
        SizedBox(height: 10),
        ScoreDisplay(label: 'BEST', value: bestScore),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onHome,
              child: Text(
                'HOME',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextButton(
              onPressed: onRestart,
              child: Text(
                'RESTART',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        if (isLastLevel)
          CustomButton(text: 'FINISH', onPressed: onHome)
        else
          CustomButton(
            text: 'NEXT',
            onPressed: () {
              context.push('/game/${levelNumber + 1}');
            },
          ),
      ],
    );
  }
}
