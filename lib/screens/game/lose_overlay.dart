import 'package:flutter/material.dart';
import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/screens/game/game_overlay_widgets.dart';

class LoseOverlay extends StatelessWidget {
  final int score;
  final int bestScore;
  final VoidCallback onTryAgain;
  final VoidCallback onHome;

  const LoseOverlay({
    super.key,
    required this.score,
    required this.bestScore,
    required this.onTryAgain,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return GameOverlayBase(
      children: [
        Text(
          'YOU LOSE!',
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
        CustomButton(text: 'TRY AGAIN', onPressed: onTryAgain),
      ],
    );
  }
}
