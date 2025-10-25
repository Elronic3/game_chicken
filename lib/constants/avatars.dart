class AvatarData {
  final String id;
  final String assetPath;

  const AvatarData({required this.id, required this.assetPath});
}

class Avatars {
  static const List<AvatarData> all = [chicken1, chicken2];

  static const chicken1 = AvatarData(
    id: 'chicken_1',
    assetPath: 'assets/images/chicken1.png',
  );
  static const chicken2 = AvatarData(
    id: 'chicken_2',
    assetPath: 'assets/images/chicken2.png',
  );

  static String getPathById(String id) {
    return all.firstWhere((avatar) => avatar.id == id).assetPath;
  }
}
