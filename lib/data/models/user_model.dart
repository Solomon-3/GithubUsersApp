import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String login,
    required String avatarUrl,
    required String name,
    required String followers,
    required String following,
    required String type,
    required String bio,
  }) : super(
    login: login,
    avatarUrl: avatarUrl,
    name: name,
    followers: followers,
    following: following,
    type: type,
    bio: bio,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'] ?? '',
      followers: json['followers'].toString(),
      following: json['following'].toString() ,
      type: json['type'],
      bio: json['bio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
      'name': name,
      'followers': followers,
      'following': following,
      'type': type,
      'bio': bio,
    };
  }

  User toEntity() {
    return User(
      login: login,
      avatarUrl: avatarUrl,
      name: name,
      followers: followers,
      following: following,
      type: type,
      bio: bio,
    );
  }
}
