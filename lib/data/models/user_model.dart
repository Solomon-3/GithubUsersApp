import 'package:githubUsers/data/models/user_list_model.dart';

import '../../domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {


  final String login;

  @JsonKey(name: "avatar_url")
  final String avatarUrl;

  @JsonKey(name: "subscriptions_url")
  final String? subscriptionsUrl;

  @JsonKey(name: "repos_url")
  final String? reposUrl;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "bio")
  final String? bio;

  @JsonKey(name: "followers")
  final int? followers;

  @JsonKey(name: "following")
  final int? following;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "type")
  final String? type;

  UserModel(this.login, this.avatarUrl, this.subscriptionsUrl, this.reposUrl, this.name, this.bio, this.followers, this.following, this.email, this.type);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Convert UserModel to User entity
  User toEntity() {
    return User(
      login: login,
      avatarUrl: avatarUrl,
      // url: url ?? '',
      subscriptionsUrl: subscriptionsUrl ?? '',
      reposUrl: reposUrl ?? '',
      name: name ?? '',
      type: type ?? '',
      followers: followers ?? 0,
      following: following ?? 0,
      bio: bio ?? '',
      email: email ?? '',
    );
  }

}