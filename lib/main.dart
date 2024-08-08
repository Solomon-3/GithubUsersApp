import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/use_cases/get_user_detail.dart';
import 'domain/use_cases/search_user_by_username.dart';
import 'domain/use_cases/search_user_by_location.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/internet_provider.dart';
import 'presentation/screens/user_search_screen.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/data_sources/user_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'presentation/providers/user_detail_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/user_profile_screen.dart';
import 'presentation/colors/colors.dart';

void main() {
  final userRemoteDataSource = UserRemoteDataSourceImpl(client: http.Client());
  final userRepository = UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
  final searchUsersByLocation = SearchUsersByLocation(userRepository);
  final getUserDetail = GetUserDetail(userRepository);
  final searchUserByUsername = SearchUserByUsername(userRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(searchUsersByLocation: searchUsersByLocation, searchUsersByUsername: searchUserByUsername),
        ),
        ChangeNotifierProvider(
          create: (_) => InternetProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => UsernameSearchProvider(searchUserByUsername: searchUserByUsername),
        // ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub User Search',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          background: AppColors.backgroundColor,
          surface: AppColors.surfaceColor,
          error: AppColors.errorColor,
          onPrimary: AppColors.onPrimaryColor,
          onSecondary: AppColors.onSecondaryColor,
          onBackground: AppColors.onBackgroundColor,
          onSurface: AppColors.onSurfaceColor,
          onError: AppColors.onErrorColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
        ),
        textTheme: TextTheme(
          labelLarge: TextStyle(color: AppColors.onBackgroundColor),
          labelMedium: TextStyle(color: AppColors.onBackgroundColor),
        ),
      ),
      home: SplashScreen(),
      // routes: {
      //   '/search_by_username': (context) => UserSearchByUsernameScreen(),
      // },
      //home: UserSearchScreen(),
    );
  }
}

