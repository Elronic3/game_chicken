import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/profile_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/level_provider.dart';
import 'providers/shop_provider.dart';
import 'services/prefs_service.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsService = PrefsService();
  await prefsService.init();

  final appRouter = AppRouter();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(prefsService)..loadSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(prefsService)..loadProfile(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopProvider(prefsService)..loadShopData(),
        ),
        ChangeNotifierProvider(
          create: (context) => LevelProvider(prefsService)..loadLevelData(),
        ),
      ],
      child: MyApp(appRouter: appRouter),
    ),
  );
}
