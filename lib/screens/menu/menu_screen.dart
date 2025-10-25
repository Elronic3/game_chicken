import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/widgets/game_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  context.pop();
                },
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'PROFILE',
                    onPressed: () => context.push('/profile'),
                  ),
                  CustomButton(
                    text: 'SETTINGS',
                    onPressed: () => context.push('/settings'),
                  ),
                  CustomButton(
                    text: 'LEADERBOARD',
                    onPressed: () => context.push('/leaderboard'),
                  ),
                  CustomButton(
                    text: 'PRIVACY POLICY',
                    onPressed: () => context.pop(),
                  ),
                  CustomButton(
                    text: 'TERMS OF USE',
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
