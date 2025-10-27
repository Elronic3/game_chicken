import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:chicken_game/providers/level_provider.dart';
import 'package:chicken_game/providers/shop_provider.dart';
import 'package:chicken_game/providers/settings_provider.dart';
import 'package:chicken_game/widgets/game_background.dart';

import 'package:chicken_game/screens/game/game_models.dart';
import 'package:chicken_game/screens/game/game_hud.dart';
import 'package:chicken_game/screens/game/egg_widget.dart';
import 'package:chicken_game/screens/game/basket_widget.dart';
import 'package:chicken_game/screens/game/pause_overlay.dart';
import 'package:chicken_game/screens/game/win_overlay.dart';
import 'package:chicken_game/screens/game/lose_overlay.dart';

class GameScreen extends StatefulWidget {
  final String levelId;
  const GameScreen({super.key, required this.levelId});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late Size _screenSize;
  bool _isScreenSizeInitialized = false;

  late AnimationController _gameLoop;
  GameStatus _status = GameStatus.playing;

  late int _levelNumber;
  late int _targetScore;
  late double _eggSpeed;
  late Duration _spawnRate;

  final List<Egg> _eggs = [];
  int _score = 0;
  int _bestScore = 0;
  int _lives = 3;
  double _basketPosition = 0.5;
  final double _basketWidthFactor = 0.25;
  Timer? _spawnTimer;

  late String _eggSkinPath;
  late SettingsProvider _settings;

  @override
  void initState() {
    super.initState();
    _levelNumber = int.parse(widget.levelId);

    _settings = context.read<SettingsProvider>();
    _eggSkinPath = context.read<ShopProvider>().activeSkinAssetPath;
    _bestScore = context.read<LevelProvider>().getBestScore(_levelNumber);

    _targetScore = 5 + (_levelNumber * 2);
    _eggSpeed = 0.003 + (_levelNumber * 0.001);
    _spawnRate = Duration(milliseconds: 1200 - (_levelNumber * 100));
    if (_spawnRate < Duration(milliseconds: 500)) {
      _spawnRate = Duration(milliseconds: 500);
    }

    _gameLoop = AnimationController(
      vsync: this,
      duration: const Duration(days: 99),
    )..addListener(_onTick);

    _startGame();
  }

  @override
  void dispose() {
    _gameLoop.dispose();
    _spawnTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _eggs.clear();
      _score = 0;
      _lives = 3;
      _status = GameStatus.playing;
    });
    _gameLoop.forward();
    _spawnTimer = Timer.periodic(_spawnRate, (_) => _spawnEgg());
  }

  void _spawnEgg() {
    if (_status != GameStatus.playing) return;
    setState(() {
      _eggs.add(
        Egg(
          x: Random().nextDouble(),
          y: -0.1,
          id: DateTime.now().microsecondsSinceEpoch.toString(),
        ),
      );
    });
  }

  void _onTick() {
    if (_status != GameStatus.playing) return;

    if (!_isScreenSizeInitialized) return;

    final basketRect = Rect.fromLTWH(
      (_basketPosition - _basketWidthFactor / 2) * _screenSize.width,
      _screenSize.height * 0.85,
      _screenSize.width * _basketWidthFactor,
      50,
    );

    List<Egg> eggsToRemove = [];
    bool shouldUpdateScoreOrLives = false;

    for (var egg in _eggs) {
      egg.y += _eggSpeed;

      final eggRect = Rect.fromLTWH(
        egg.x * _screenSize.width - 25,
        egg.y * _screenSize.height,
        50,
        50,
      );

      if (basketRect.overlaps(eggRect)) {
        eggsToRemove.add(egg);
        _score++;
        shouldUpdateScoreOrLives = true;
        if (_settings.isVibrationOn) HapticFeedback.lightImpact();

        if (_score >= _targetScore) {
          _winGame();
          break;
        }
      } else if (egg.y > 1.1) {
        eggsToRemove.add(egg);
        _lives--;
        shouldUpdateScoreOrLives = true;
        if (_settings.isVibrationOn) HapticFeedback.heavyImpact();

        if (_lives <= 0) {
          _loseGame();
          break;
        }
      }
    }

    if (eggsToRemove.isNotEmpty || shouldUpdateScoreOrLives) {
      setState(() {
        _eggs.removeWhere((e) => eggsToRemove.contains(e));
      });
    }
  }

  void _pauseGame() {
    if (_status != GameStatus.playing) return;
    _gameLoop.stop();
    _spawnTimer?.cancel();
    setState(() => _status = GameStatus.paused);
  }

  void _resumeGame() {
    if (_status != GameStatus.paused) return;
    _gameLoop.forward();
    _spawnTimer = Timer.periodic(_spawnRate, (_) => _spawnEgg());
    setState(() => _status = GameStatus.playing);
  }

  void _winGame() {
    _gameLoop.stop();
    _spawnTimer?.cancel();
    setState(() => _status = GameStatus.won);

    if (_score > _bestScore) {
      _bestScore = _score;
      context.read<LevelProvider>().saveBestScore(_levelNumber, _score);
    }

    context.read<ShopProvider>().addTokens(_score);
    context.read<LevelProvider>().completeLevel(_levelNumber);
  }

  void _loseGame() {
    _gameLoop.stop();
    _spawnTimer?.cancel();
    setState(() => _status = GameStatus.lost);
  }

  void _restartGame() {
    _spawnTimer?.cancel();
    _startGame();
  }

  void _goHome() {
    context.go('/home');
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_status != GameStatus.playing) return;
    double delta = details.delta.dx / _screenSize.width;
    _basketPosition = (_basketPosition + delta).clamp(
      _basketWidthFactor / 2,
      1.0 - _basketWidthFactor / 2,
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    if (!_isScreenSizeInitialized) {
      _screenSize = MediaQuery.of(context).size;
      _isScreenSizeInitialized = true;
    }

    return Scaffold(
      body: GameBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              child: AnimatedBuilder(
                animation: _gameLoop,
                builder: (context, child) {
                  return Stack(
                    children: [
                      ..._eggs.map(
                        (egg) => EggWidget(
                          egg: egg,
                          eggSkinPath: _eggSkinPath,
                          key: ValueKey(egg.id),
                        ),
                      ),
                      BasketWidget(
                        basketPosition: _basketPosition,
                        basketWidthFactor: _basketWidthFactor,
                      ),
                    ],
                  );
                },
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: GameHUD(
                  score: _score,
                  lives: _lives,
                  onPausePressed: _pauseGame,
                ),
              ),
            ),

            if (_status == GameStatus.paused)
              PauseOverlay(
                onResume: _resumeGame,
                onRestart: _restartGame,
                onHome: _goHome,
              ),
            if (_status == GameStatus.won)
              WinOverlay(
                levelNumber: _levelNumber,
                totalLevels: LevelProvider.totalLevels,
                score: _score,
                bestScore: _bestScore,
                onRestart: _restartGame,
                onHome: _goHome,
              ),
            if (_status == GameStatus.lost)
              LoseOverlay(
                score: _score,
                bestScore: _bestScore,
                onTryAgain: _restartGame,
                onHome: _goHome,
              ),
          ],
        ),
      ),
    );
  }
}
