import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchUsersByLocation {
  final UserRepository repository;

  SearchUsersByLocation(this.repository);

  Future<Either<Exception, List<User>>> call(String location, int page) {
    return repository.searchUsersByLocation(location, page);
  }
}
