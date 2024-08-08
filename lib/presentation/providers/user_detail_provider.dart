import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_cases/get_user_detail.dart';

class UserDetailProvider extends ChangeNotifier {
  final GetUserDetail getUserDetail;

  UserDetailProvider({required this.getUserDetail});

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchUserDetail(String username) async {
    _isLoading = true;
    notifyListeners();

    final result = await getUserDetail.call(username);
    result.fold(
          (exception) {
          print('Error fetching user detail: $exception');
        },
          (user) {
        _user = user;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
