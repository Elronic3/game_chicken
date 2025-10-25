import 'package:chicken_game/widgets/game_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  double _items = 0.0;
  final int _totalItems = 12;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);

    _startLoading();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await _preloadImages();

    if (!mounted) return;
    context.replace('/home');
  }

  Future<void> _preloadImages() async {
    final images = [
      'assets/images/main_bg.png',
      'assets/images/chicken1.png',
      'assets/images/chicken2.png',
      'assets/images/sparkle_lines.png',
      'assets/images/play_button.png',
      'assets/images/settings_bg.png',
      'assets/images/play_bg.png',
      'assets/images/back_button.png',
      'assets/images/flame.png',
      'assets/images/circle.png',
      'assets/images/start_button.png',
      'assets/images/coin.png',
    ];

    for (var i = 0; i < images.length; i++) {
      final path = images[i];

      await precacheImage(AssetImage(path), context);
      setState(() {
        _items = (i + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = _items / _totalItems;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GameBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Image.asset(
                'assets/images/chicken1.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCustomProgressBar(context, progress),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomProgressBar(BuildContext context, double progress) {
    final double barHeight = 50.0;
    final BorderRadius borderRadius = BorderRadius.circular(14.0);
    final double barWidth = MediaQuery.of(context).size.width * 0.8;

    return Center(
      child: SizedBox(
        width: barWidth,
        height: barHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),

            ClipRRect(
              borderRadius: borderRadius,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  height: barHeight,
                  width: (barWidth * 2) * progress,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.yellow],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ),

            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.brown.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.white.withAlpha(140),
                    offset: const Offset(1, 1),
                    blurRadius: 1,
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
