import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchUserByUsername {
  final UserRepository repository;

  SearchUserByUsername(this.repository);

  Future<Either<Exception, User>> call(String username, int page) {
    return repository.searchUsersByUsername(username, page);
  }
}
