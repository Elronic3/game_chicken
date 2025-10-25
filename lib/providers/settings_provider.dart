import 'package:chicken_game/services/prefs_service.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  final PrefsService _prefsService;

  SettingsProvider(this._prefsService);

  bool _isSoundOn = true;
  bool _isVibrationOn = true;
  bool _isNotificationOn = true;

  bool get isSoundOn => _isSoundOn;
  bool get isVibrationOn => _isVibrationOn;
  bool get isNotificationOn => _isNotificationOn;

  void loadSettings() {
    _isSoundOn = _prefsService.getSoundSetting();
    _isVibrationOn = _prefsService.getVibrationSetting();
    _isNotificationOn = _prefsService.getNotificationSetting();
  }

  Future<void> toggleSound(bool newValue) async {
    _isSoundOn = newValue;
    await _prefsService.saveSoundSetting(newValue);
    notifyListeners();
  }

  Future<void> toggleVibration(bool newValue) async {
    _isVibrationOn = newValue;
    await _prefsService.saveVibrationSetting(newValue);
    notifyListeners();
  }

  Future<void> toggleNotification(bool newValue) async {
    _isNotificationOn = newValue;
    await _prefsService.saveNotificationSetting(newValue);
    notifyListeners();
  }
}
