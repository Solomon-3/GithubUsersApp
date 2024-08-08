import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserName{
  final UserRepository repository;

  GetUserName(this.repository);

  Future<Either<Exception,User>> call(int id) async {
    return await repository.getUser(id);
  }
}
