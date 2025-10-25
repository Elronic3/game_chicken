import 'package:flutter/material.dart';
import 'package:chicken_game/services/prefs_service.dart';

class Skin {
  final String id;
  final String name;
  final int price;
  final String assetPath;

  Skin({
    required this.id,
    required this.name,
    required this.price,
    required this.assetPath,
  });
}

class ShopProvider extends ChangeNotifier {
  final PrefsService _prefsService;

  late int _playerBalance;
  late List<String> _purchasedSkinIds;
  late String _activeSkinId;

  int get playerBalance => _playerBalance;
  List<String> get purchasedSkinIds => _purchasedSkinIds;
  String get activeSkinId => _activeSkinId;

  static final List<Skin> shopItems = [
    Skin(
      id: 'egg_default',
      name: 'Green Egg',
      price: 0,
      assetPath: 'assets/images/egg_green.png',
    ),
    Skin(
      id: 'egg_default2',
      name: 'Orange Egg',
      price: 0,
      assetPath: 'assets/images/egg_orange.png',
    ),
    Skin(
      id: 'egg1',
      name: 'Egg 1',
      price: 100,
      assetPath: 'assets/images/egg1.png',
    ),
    Skin(
      id: 'egg2',
      name: 'Egg 2',
      price: 200,
      assetPath: 'assets/images/egg2.png',
    ),
    Skin(
      id: 'egg3',
      name: 'Egg 3',
      price: 300,
      assetPath: 'assets/images/egg3.png',
    ),
    Skin(
      id: 'egg4',
      name: 'Egg 4',
      price: 400,
      assetPath: 'assets/images/egg4.png',
    ),
    Skin(
      id: 'egg5',
      name: 'Egg 5',
      price: 500,
      assetPath: 'assets/images/egg5.png',
    ),
    Skin(
      id: 'egg6',
      name: 'Egg 6',
      price: 600,
      assetPath: 'assets/images/egg6.png',
    ),
    Skin(
      id: 'egg7',
      name: 'Egg 7',
      price: 700,
      assetPath: 'assets/images/egg7.png',
    ),
    Skin(
      id: 'egg8',
      name: 'Egg 8',
      price: 800,
      assetPath: 'assets/images/egg8.png',
    ),
    Skin(
      id: 'egg9',
      name: 'Egg 9',
      price: 900,
      assetPath: 'assets/images/egg9.png',
    ),
  ];

  ShopProvider(this._prefsService);

  void loadShopData() {
    _playerBalance = _prefsService.getPlayerBalance();
    _purchasedSkinIds = _prefsService.getPurchasedSkins();
    _activeSkinId = _prefsService.getActiveSkin();
  }

  Future<bool> buySkin(Skin skin) async {
    if (_playerBalance >= skin.price) {
      if (!_purchasedSkinIds.contains(skin.id)) {
        _playerBalance -= skin.price;
        _purchasedSkinIds.add(skin.id);

        await _prefsService.savePlayerBalance(_playerBalance);
        await _prefsService.savePurchasedSkins(_purchasedSkinIds);

        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<void> selectSkin(Skin skin) async {
    if (_purchasedSkinIds.contains(skin.id)) {
      if (_activeSkinId != skin.id) {
        _activeSkinId = skin.id;
        await _prefsService.saveActiveSkin(_activeSkinId);
        notifyListeners();
      }
    }
  }
}
