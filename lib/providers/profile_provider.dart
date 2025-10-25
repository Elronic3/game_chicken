import 'package:chicken_game/services/prefs_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final PrefsService _prefsService;

  late String _playerName;
  late String _playerEmail;
  late String _selectedAvatarId;

  ProfileProvider(this._prefsService);

  String get playerName => _playerName;
  String get playerEmail => _playerEmail;
  String get selectedAvatarId => _selectedAvatarId;

  void loadProfile() {
    _playerName = _prefsService.getPlayerName();
    _playerEmail = _prefsService.getPlayerEmail();
    _selectedAvatarId = _prefsService.getAvatarId();
  }

  Future<void> selectAvatar(String newAvatarId) async {
    if (_selectedAvatarId == newAvatarId) return;

    _selectedAvatarId = newAvatarId;
    await _prefsService.saveAvatarId(newAvatarId);
    notifyListeners();
  }

  Future<void> saveProfile(String newName, String newEmail) async {
    _playerName = newName;
    _playerEmail = newEmail;

    await _prefsService.savePlayerName(newName);
    await _prefsService.savePlayerEmail(newEmail);

    notifyListeners();
  }
}
