import 'package:chicken_game/providers/profile_provider.dart';
import 'package:chicken_game/widgets/custom_button.dart';
import 'package:chicken_game/widgets/game_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:chicken_game/constants/avatars.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ProfileProvider>();
    _nameController = TextEditingController(text: provider.playerName);
    _emailController = TextEditingController(text: provider.playerEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final String currentAvatarPath = Avatars.getPathById(
      provider.selectedAvatarId,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: GameBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PROFILE",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(currentAvatarPath, width: 100, height: 100),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAvatarChoice(context, Avatars.chicken1),
                  _buildAvatarChoice(context, Avatars.chicken2),
                ],
              ),
              SizedBox(height: 30),

              _buildTextField(controller: _nameController, label: 'USERNAME'),
              SizedBox(height: 20),
              _buildTextField(controller: _emailController, label: 'EMAIL'),
              SizedBox(height: 30),

              CustomButton(
                text: 'SAVE',
                onPressed: () {
                  context.read<ProfileProvider>().saveProfile(
                    _nameController.text,
                    _emailController.text,
                  );
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

Widget _buildAvatarChoice(BuildContext context, AvatarData avatar) {
  final provider = context.read<ProfileProvider>();
  final bool isSelected = provider.selectedAvatarId == avatar.id;

  return GestureDetector(
    onTap: () {
      provider.selectAvatar(avatar.id);
    },
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: Colors.yellow, width: 3)
            : Border.all(color: Colors.transparent, width: 3),
      ),
      child: Image.asset(avatar.assetPath, width: 80, height: 80),
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
      SizedBox(height: 8),
      TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withValues(alpha: 0.4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}
