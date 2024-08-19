import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_list_model.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(int id);
  Future<List<UserListModel>> searchUsersByLocation(String location, int page);
  Future<UserModel> getUserDetail(String username);
  Future<List<UserListModel>> searchUserByUsername(String name);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(int id) async {
    final response = await client.get(Uri.parse('https://api.github.com/users/$id'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  @override
  Future<List<UserListModel>> searchUsersByLocation(String location, int page) async {
    final response = await client.get(Uri.parse('https://api.github.com/search/users?q=location:$location'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((json) => UserListModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<UserModel> getUserDetail(String username) async {
    final response = await client.get(Uri.parse('https://api.github.com/users/$username'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user detail');
    }
  }

  @override
  Future<List<UserListModel>> searchUserByUsername(String name) async {
    // final response = await client.get(Uri.parse('https://api.github.com/search/users?q=$name'));
    final response = await client.get(Uri.parse('https://api.github.com/search/users?q=$name'));


    if (response.statusCode == 200) {
      //return UserModel.fromJson(json.decode(response.body));
      final data = json.decode(response.body);
      return (data['items'] as List).map((json) => UserListModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load User');
    }
  }

}
