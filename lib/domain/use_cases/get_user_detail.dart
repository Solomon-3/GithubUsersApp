import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserDetail {
  final UserRepository repository = GetIt.instance<UserRepository>();

  //GetUserDetail(this.repository);

  Future<Either<Exception, User>> call(String username) {
    return repository.getUserDetail(username);
  }
}