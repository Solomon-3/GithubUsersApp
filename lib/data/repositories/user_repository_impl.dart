import 'package:dartz/dartz.dart';
import 'package:githubUsers/domain/entities/user_list_entity.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/data_sources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, User>> getUser(int id) async {
    try {
      final model = await remoteDataSource.getUser(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Exception('Failed to fetch data'));
    }
  }

  @override
  Future<Either<Exception, List<UserListEntity>>> searchUsersByLocation(String location, int page) async {
    try {
      final models = await remoteDataSource.searchUsersByLocation(location, page);
      final userlist = models.map((model) => model.toEntity()).toList();
      return Right(userlist);
    } catch (e) {
      return Left(Exception('Failed to fetch data'));
    }
  }

  @override
  Future<Either<Exception, User>> getUserDetail(String username) async {
    try {
      final model = await remoteDataSource.getUserDetail(username);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Exception('Failed to fetch data'));
    }
  }

  @override
  Future<Either<Exception, List<UserListEntity>>> searchUsersByUsername(String name) async {
    try {
      final models = await remoteDataSource.searchUserByUsername(name);
      final users = models.map((model) => model.toEntity()).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception('Failed to fetch data'));
    }
  }
}
