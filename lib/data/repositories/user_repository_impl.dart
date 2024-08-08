import 'package:dartz/dartz.dart';
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
  Future<Either<Exception, List<User>>> searchUsersByLocation(String location, int page) async {
    try {
      final models = await remoteDataSource.searchUsersByLocation(location, page);
      final users = models.map((model) => model.toEntity()).toList();
      return Right(users);
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
  Future<Either<Exception, User>> searchUsersByUsername(String username, int page) async {
    try {
      final model = await remoteDataSource.searchUserByUsername(username);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Exception('Failed to fetch data'));
    }
  }
}
