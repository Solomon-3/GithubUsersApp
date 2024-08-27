// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['login'] as String,
      json['avatar_url'] as String,
      json['subscriptions_url'] as String?,
      json['repos_url'] as String?,
      json['name'] as String?,
      json['bio'] as String?,
      (json['followers'] as num?)?.toInt(),
      (json['following'] as num?)?.toInt(),
      json['email'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'repos_url': instance.reposUrl,
      'name': instance.name,
      'bio': instance.bio,
      'followers': instance.followers,
      'following': instance.following,
      'email': instance.email,
      'type': instance.type,
    };
