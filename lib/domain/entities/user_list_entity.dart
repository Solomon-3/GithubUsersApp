// domain/entities/userlistentity.dart
import 'package:githubUsers/domain/entities/user.dart';

class UserListEntity {
  final String login;
  final String avatarUrl;
  final String type;
  final String email;
  UserListEntity({
    required this.login,
    required this.avatarUrl,
    required this.type,
    required this.email,
  });
}