import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../domain/use_cases/search_user_by_location.dart';
import '../../domain/entities/user.dart';
import 'internet_provider.dart';
import 'package:provider/provider.dart';
import '../../domain/use_cases/search_user_by_username.dart';


class UserProvider with ChangeNotifier {
  final SearchUsersByLocation searchUsersByLocation;
  final SearchUserByUsername searchUsersByUsername;
  List<User> _users = [];
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isFetchingMore = false;
  int _page = 1;


  List<User> get users => _users;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;

  UserProvider({required this.searchUsersByLocation, required this.searchUsersByUsername});


  Future<void> searchUsers(BuildContext context, String location) async {
    final internetProvider = Provider.of<InternetProvider>(context, listen: false);
    if (!internetProvider.isConnected) {
      _errorMessage = 'No internet connection';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _page = 1;
    final result = await searchUsersByLocation(location,_page);
    result.fold(
          (error) {
        _errorMessage = error.toString();
        _users = [];
      },
          (users) {
        _errorMessage = '';
        _users = users;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
  Future<void> searchUserByUsername(BuildContext context, String username) async {
    final internetProvider = Provider.of<InternetProvider>(context, listen: false);
    if (!internetProvider.isConnected) {
      _errorMessage = 'No internet connection';
      notifyListeners();
      return;
    }
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final result = await searchUsersByUsername(username, _page);

    result.fold(
          (exception) {
        _errorMessage = exception.toString();
      },
          (user) {
        _users = [user];
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreUsers(BuildContext context, String location) async {
    if (_isFetchingMore) return;

    final internetProvider = Provider.of<InternetProvider>(context, listen: false);
    if (!internetProvider.isConnected) return;

    _isFetchingMore = true;
    notifyListeners();

    _page++;
    final result = await searchUsersByLocation(location, _page);
    result.fold(
          (error) {
        _errorMessage = error.toString();
      },
          (users) {
        _users.addAll(users);
      },
    );

    _isFetchingMore = false;
    notifyListeners();
  }
}