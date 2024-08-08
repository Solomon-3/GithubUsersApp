import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class UserRepository{
  Future<Either<Exception, User>> getUser(int id);
  Future<Either<Exception, List<User>>> searchUsersByLocation(String location, int page);
  Future<Either<Exception, User>> getUserDetail(String username);
  Future<Either<Exception, User>> searchUsersByUsername(String username, int page);
}

