import 'package:dartz/dartz.dart';
import 'package:githubUsers/domain/entities/user_list_entity.dart';
import '../entities/user.dart';

abstract class UserRepository{
  Future<Either<Exception, User>> getUser(int id);
  Future<Either<Exception, List<UserListEntity>>> searchUsersByLocation(String location, int page);
  Future<Either<Exception, User>> getUserDetail(String username);
  Future<Either<Exception,  List<UserListEntity>>> searchUsersByUsername(String name);
}

