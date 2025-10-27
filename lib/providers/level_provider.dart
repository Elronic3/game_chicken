import 'package:chicken_game/services/prefs_service.dart';
import 'package:flutter/material.dart';

class LevelProvider extends ChangeNotifier {
  final PrefsService _prefsService;

  static const int totalLevels = 9;

  late int _highestUnlockedLevel;

  LevelProvider(this._prefsService);

  int get highestUnlockedLevel => _highestUnlockedLevel;

  void loadLevelData() {
    _highestUnlockedLevel = _prefsService.getUnlockedLevel();
  }

  bool isLevelUnlocked(int levelNumber) {
    return levelNumber <= _highestUnlockedLevel;
  }

  Future<void> completeLevel(int completedLevelNumber) async {
    int nextLevel = completedLevelNumber + 1;

    if (nextLevel > _highestUnlockedLevel &&
        completedLevelNumber <= totalLevels) {
      _highestUnlockedLevel = nextLevel;
      await _prefsService.saveUnlockedLevel(_highestUnlockedLevel);
      notifyListeners();
    }
  }

  int getBestScore(int levelNumber) {
    return _prefsService.getBestScore(levelNumber);
  }

  Future<void> saveBestScore(int levelNumber, int score) async {
    final currentBest = _prefsService.getBestScore(levelNumber);
    if (score > currentBest) {
      await _prefsService.saveBestScore(levelNumber, score);
    }
  }
}
