import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  final Widget child;
  const GameBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
