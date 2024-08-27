import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:githubUsers/domain/entities/user_list_entity.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchUsersByLocation {
  final UserRepository repository = GetIt.instance<UserRepository>();

 // SearchUsersByLocation(this.repository);

  Future<Either<Exception, List<UserListEntity>>> call(String location, int page) {
    return repository.searchUsersByLocation(location, page);
  }
}