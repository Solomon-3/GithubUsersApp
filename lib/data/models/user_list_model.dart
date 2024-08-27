import '../../domain/entities/user_list_entity.dart';

import 'package:json_annotation/json_annotation.dart';
part 'user_list_model.g.dart';

@JsonSerializable()
class UserListModel{
  final String login;

  @JsonKey(name: "avatar_url")
  final String avatarUrl;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "type")
  final String? type;

  UserListModel( this.login, this.email, this.type, this.avatarUrl);

  factory UserListModel.fromJson(Map<String, dynamic> json) => _$UserListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListModelToJson(this);

  // Convert User listModel to User list entity
  UserListEntity toEntity() {
    return UserListEntity(
      login: login,
      avatarUrl: avatarUrl,
      type: type ?? '',
      email: email ?? '',
    );
  }
}