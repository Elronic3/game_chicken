import 'package:chicken_game/providers/shop_provider.dart';
import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/widgets/game_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShopProvider>();
    final List<Skin> items = ShopProvider.shopItems;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text('SHOP'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Image.asset('assets/images/coin.png', width: 30, height: 30),
                SizedBox(width: 8),
                Text(
                  provider.playerBalance.toString(),
                  style: TextStyle(color: Colors.yellow, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GameBackground(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final Skin skin = items[index];
            final bool isOwned = provider.purchasedSkinIds.contains(skin.id);
            final bool isActive = provider.activeSkinId == skin.id;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? Border.all(color: Colors.yellow, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Image.asset(skin.assetPath, width: 60, height: 60),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      skin.name.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  _buildShopButton(context, provider, skin, isOwned, isActive),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShopButton(
    BuildContext context,
    ShopProvider provider,
    Skin skin,
    bool isOwned,
    bool isActive,
  ) {
    if (isActive) {
      return Text(
        "SELECTED",
        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
      );
    }

    if (isOwned) {
      return CustomButton(
        text: 'SELECT',
        onPressed: () {
          context.read<ShopProvider>().selectSkin(skin);
        },
      );
    }

    return CustomButton(
      text: '${skin.price}',
      onPressed: () async {
        bool success = await context.read<ShopProvider>().buySkin(skin);
        if (!success && context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Not enough coins!')));
        }
      },
    );
  }
}
