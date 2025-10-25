import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/widgets/game_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                icon: Icon(Icons.info_outline, color: Colors.white, size: 30),
                onPressed: () {
                  context.push('/how-to-play');
                },
              ),
            ),

            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: () {
                  context.push('/menu');
                },
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/chicken1.png', height: 250),
                  SizedBox(height: 50),

                  CustomButton(
                    text: 'PLAY',
                    onPressed: () {
                      context.push('/levels');
                    },
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
