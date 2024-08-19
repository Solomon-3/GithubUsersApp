import 'package:flutter/material.dart';
import 'package:githubUsers/data/repositories/user_repository_impl.dart';
import 'package:provider/provider.dart';
import '../../data/data_sources/user_remote_data_source.dart';
import '../../domain/use_cases/get_user_detail.dart';
import '../providers/user_detail_provider.dart';
import '../providers/user_provider.dart';
import 'user_profile_screen.dart';
import 'package:http/http.dart' as http;
import '../colors/colors.dart';



class UserSearchScreen extends StatefulWidget {
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLocationSearch = true;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .searchUsers(context, _locationController.text);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub User Search'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Search by Location'),
                  selected: _isLocationSearch,
                  onSelected: (selected) {
                    setState(() {
                      _isLocationSearch = true;
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Search by Username'),
                  selected: !_isLocationSearch,
                  onSelected: (selected) {
                    setState(() {
                      _isLocationSearch = false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _isLocationSearch
                ? TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Enter location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .searchUsers(context, _locationController.text);
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            )
                : TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter username',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .searchUserByUsername(context, _usernameController.text);
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (userProvider.errorMessage.isNotEmpty) {
                    return Center(child: Text(userProvider.errorMessage));
                  } else {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                            !userProvider.isFetchingMore &&
                            _isLocationSearch) {
                          userProvider.loadMoreUsers(context, _locationController.text);
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: userProvider.users.length +
                            (userProvider.isFetchingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == userProvider.users.length) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final user = userProvider.users[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (_) => UserDetailProvider(
                                        getUserDetail: GetUserDetail(
                                            UserRepositoryImpl(
                                                remoteDataSource:
                                                UserRemoteDataSourceImpl(
                                                    client:
                                                    http.Client()))))..fetchUserDetail(user.login),
                                    child: UserProfileScreen(),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatarUrl),
                              ),
                              title: Text(user.login),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class UserSearchScreen extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   bool _isLocationSearch = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GitHub User Search'),
//         backgroundColor: AppColors.primaryColor,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               Navigator.pushNamed(context, '/search_by_username');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Enter location',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     Provider.of<UserProvider>(context, listen: false)
//                         .searchUsers(context, _controller.text);
//                   },
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppColors.primaryColor),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Consumer<UserProvider>(
//                 builder: (context, userProvider, child) {
//                   if (userProvider.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (userProvider.errorMessage.isNotEmpty) {
//                     return Center(child: Text(userProvider.errorMessage));
//                   } else {
//                     return NotificationListener<ScrollNotification>(
//                       onNotification: (ScrollNotification scrollInfo) {
//                         if (scrollInfo.metrics.pixels ==
//                                 scrollInfo.metrics.maxScrollExtent &&
//                             !userProvider.isFetchingMore) {
//                           userProvider.loadMoreUsers(context, _controller.text);
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         itemCount: userProvider.users.length +
//                             (userProvider.isFetchingMore ? 1 : 0),
//                         itemBuilder: (context, index) {
//                           if (index == userProvider.users.length) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           final user = userProvider.users[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ChangeNotifierProvider(
//                                     create: (_) => UserDetailProvider(
//                                         getUserDetail: GetUserDetail(
//                                             UserRepositoryImpl(
//                                                 remoteDataSource:
//                                                     UserRemoteDataSourceImpl(
//                                                         client:
//                                                             http.Client()))))..fetchUserDetail(user.login),
//                                     child: UserProfileScreen(user: user),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(user.avatarUrl),
//                               ),
//                               title: Text(user.login),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



