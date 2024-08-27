// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListModel _$UserListModelFromJson(Map<String, dynamic> json) =>
    UserListModel(
      json['login'] as String,
      json['email'] as String?,
      json['type'] as String?,
      json['avatar_url'] as String,
    );

Map<String, dynamic> _$UserListModelToJson(UserListModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'email': instance.email,
      'type': instance.type,
    };
