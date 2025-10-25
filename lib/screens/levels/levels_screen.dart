import 'package:chicken_game/providers/level_provider.dart';
import 'package:chicken_game/providers/shop_provider.dart';
import 'package:chicken_game/widgets/game_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levelProvider = context.watch<LevelProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('CHANGE LEVEL'),
        actions: [
          GestureDetector(
            onTap: () {
              context.push('/shop');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Image.asset('assets/images/coin.png', width: 30, height: 30),
                  SizedBox(width: 8),
                  Text(
                    context.watch<ShopProvider>().playerBalance.toString(),
                    style: TextStyle(color: Colors.yellow, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GameBackground(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final int levelNumber = index + 1;
              final bool isUnlocked = levelProvider.isLevelUnlocked(
                levelNumber,
              );

              return GestureDetector(
                onTap: () {
                  if (isUnlocked) {
                    context.push('/game/$levelNumber');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Level $levelNumber is locked!')),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/back_button.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '$levelNumber',
                          style: TextStyle(
                            color: isUnlocked ? Colors.white : Colors.grey[700],
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (!isUnlocked)
                          Container(
                            color: Colors.black.withValues(alpha: 0.5),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
