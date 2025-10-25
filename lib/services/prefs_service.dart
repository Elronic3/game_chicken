import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  late SharedPreferences _prefs;

  // Profile
  static const String playerNameKey = 'playerName';
  static const String playerEmailKey = 'playerEmail';
  static const String avatarIdKey = 'avatarId';

  // Settings
  static const String soundKey = 'sound';
  static const String vibrationKey = 'vibration';
  static const String notificationsKey = 'notifications';

  // Shop & Player Data
  static const String playerBalanceKey = 'playerBalance';
  static const String purchasedSkinsKey = 'purchasedSkins';
  static const String activeSkinKey = 'activeSkin';

  // Level Data
  static const String unlockedLevelKey = 'unlockedLevel';

  // Best Score Data
  String _bestScoreKey(int level) => 'bestScore_$level';

  // Default
  static const String defaultPlayerName = 'Player';
  static const String defaultPlayerEmail = 'email';
  static const String defaultAvatarId = 'chicken_1';
  static const int defaultBalance = 1000;
  static const String defaultActiveSkin = 'egg_default';
  static const int defaultUnlockedLevel = 1;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Profile
  Future<void> savePlayerName(String name) async {
    await _prefs.setString(playerNameKey, name);
  }

  String getPlayerName() {
    return _prefs.getString(playerNameKey) ?? defaultPlayerName;
  }

  Future<void> savePlayerEmail(String email) async {
    await _prefs.setString(playerEmailKey, email);
  }

  String getPlayerEmail() {
    return _prefs.getString(playerEmailKey) ?? defaultPlayerEmail;
  }

  Future<void> saveAvatarId(String avatarId) async {
    await _prefs.setString(avatarIdKey, avatarId);
  }

  String getAvatarId() {
    return _prefs.getString(avatarIdKey) ?? defaultAvatarId;
  }

  // Settings
  Future<void> saveSoundSetting(bool value) async {
    await _prefs.setBool(soundKey, value);
  }

  bool getSoundSetting() {
    return _prefs.getBool(soundKey) ?? true;
  }

  Future<void> saveVibrationSetting(bool value) async {
    await _prefs.setBool(vibrationKey, value);
  }

  bool getVibrationSetting() {
    return _prefs.getBool(vibrationKey) ?? true;
  }

  Future<void> saveNotificationSetting(bool value) async {
    await _prefs.setBool(notificationsKey, value);
  }

  bool getNotificationSetting() {
    return _prefs.getBool(notificationsKey) ?? true;
  }

  // Shop & Player Data

  Future<void> savePlayerBalance(int balance) async {
    await _prefs.setInt(playerBalanceKey, balance);
  }

  int getPlayerBalance() {
    return _prefs.getInt(playerBalanceKey) ?? defaultBalance;
  }

  Future<void> savePurchasedSkins(List<String> skinIds) async {
    await _prefs.setStringList(purchasedSkinsKey, skinIds);
  }

  List<String> getPurchasedSkins() {
    return _prefs.getStringList(purchasedSkinsKey) ?? [defaultActiveSkin];
  }

  Future<void> saveActiveSkin(String skinId) async {
    await _prefs.setString(activeSkinKey, skinId);
  }

  String getActiveSkin() {
    return _prefs.getString(activeSkinKey) ?? defaultActiveSkin;
  }

  // Level Data
  Future<void> saveUnlockedLevel(int level) async {
    await _prefs.setInt(unlockedLevelKey, level);
  }

  int getUnlockedLevel() {
    return _prefs.getInt(unlockedLevelKey) ?? defaultUnlockedLevel;
  }

  // Best Score Data
  Future<void> saveBestScore(int level, int score) async {
    await _prefs.setInt(_bestScoreKey(level), score);
  }

  int getBestScore(int level) {
    return _prefs.getInt(_bestScoreKey(level)) ?? 0;
  }
}
