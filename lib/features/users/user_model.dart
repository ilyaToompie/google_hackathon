class UserModel {
  final String uid;
  final String username;
  final String avatarUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.avatarUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      username: map['username'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'username': username, 'avatarUrl': avatarUrl};
  }
}
