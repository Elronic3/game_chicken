import 'package:flutter/material.dart';
import 'package:chicken_game/routing/app_router.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chicken Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      routerConfig: appRouter.router,
    );
  }
}
