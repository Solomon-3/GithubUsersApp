import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/data_sources/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/use_cases/get_user_detail.dart';
import 'domain/use_cases/search_user_by_location.dart';
import 'domain/use_cases/search_user_by_username.dart';
import 'presentation/providers/user_detail_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/internet_provider.dart';


final getIt = GetIt.instance;

void setupLocator() {
  // Register InternetProvider as a singleton
  getIt.registerLazySingleton<InternetProvider>(() => InternetProvider());

  // Register Http Client
  getIt.registerLazySingleton(() => http.Client());

  // Register Data Sources
  getIt.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(),
  );

  // Register Repositories
  getIt.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(),
  );

  // Register Use Cases
  getIt.registerLazySingleton(() => SearchUsersByLocation());
  getIt.registerLazySingleton(() => GetUserDetail());
  getIt.registerLazySingleton(() => SearchUserByUsername());


  // Register Providers
  getIt.registerFactory(() => UserProvider());
  getIt.registerFactory(() => UserDetailProvider());
}