import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserDetail {
  final UserRepository repository;

  GetUserDetail(this.repository);

  Future<Either<Exception, User>> call(String username) {
    return repository.getUserDetail(username);
  }
}
