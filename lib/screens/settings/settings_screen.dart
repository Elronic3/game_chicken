import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:chicken_game/providers/settings_provider.dart';
import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/widgets/game_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: GameBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSettingRow(
                title: 'SOUND',
                value: settings.isSoundOn,
                onChanged: (newValue) {
                  context.read<SettingsProvider>().toggleSound(newValue);
                },
              ),
              const SizedBox(height: 20),

              _buildSettingRow(
                title: 'VIBRATION',
                value: settings.isVibrationOn,
                onChanged: (newValue) {
                  context.read<SettingsProvider>().toggleVibration(newValue);
                },
              ),
              const SizedBox(height: 20),

              _buildSettingRow(
                title: 'NOTIFICATION',
                value: settings.isNotificationOn,
                onChanged: (newValue) {
                  context.read<SettingsProvider>().toggleNotification(newValue);
                },
              ),

              const SizedBox(height: 50),

              CustomButton(
                text: 'BACK',
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSettingRow({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.purple,
          inactiveThumbColor: Colors.grey,
        ),
      ],
    ),
  );
}
