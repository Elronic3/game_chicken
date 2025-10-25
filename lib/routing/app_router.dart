import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chicken_game/screens/loading/loading_screen.dart';
import 'package:chicken_game/screens/home/home_screen.dart';
import 'package:chicken_game/screens/menu/menu_screen.dart';
import 'package:chicken_game/screens/levels/levels_screen.dart';
import 'package:chicken_game/screens/profile/profile_screen.dart';
import 'package:chicken_game/screens/settings/settings_screen.dart';
import 'package:chicken_game/screens/shop/shop_screen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoadingScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/menu', builder: (context, state) => const MenuScreen()),
      GoRoute(
        path: '/levels',
        builder: (context, state) => const LevelsScreen(),
      ),
      GoRoute(
        path: '/how-to-play',
        builder: (context, state) {
          return Text('TODO: how-to-play');
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) {
          return Text('TODO: leaderboard');
        },
      ),
      GoRoute(path: '/shop', builder: (context, state) => const ShopScreen()),
    ],
  );
}
