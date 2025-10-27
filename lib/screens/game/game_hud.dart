import 'package:flutter/material.dart';

class GameHUD extends StatelessWidget {
  final int score;
  final int lives;
  final VoidCallback onPausePressed;

  const GameHUD({
    super.key,
    required this.score,
    required this.lives,
    required this.onPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoBox(
              icon: 'assets/images/coin.png',
              text: score.toString(),
            ),

            _buildInfoBox(
              icon: 'assets/images/heart.png',
              text: lives.toString(),
            ),

            IconButton(
              iconSize: 50,
              onPressed: onPausePressed,
              icon: Icon(Icons.pause_circle_filled, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox({required String icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(icon, width: 24, height: 24),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
