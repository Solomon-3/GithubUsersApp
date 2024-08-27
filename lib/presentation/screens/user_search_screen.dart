import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:githubUsers/data/repositories/user_repository_impl.dart';
import 'package:provider/provider.dart';
import '../../data/data_sources/user_remote_data_source.dart';
import '../../domain/use_cases/get_user_detail.dart';
import '../providers/user_detail_provider.dart';
import '../providers/user_provider.dart';
import 'user_profile_screen.dart';
import 'package:http/http.dart' as http;
import '../colors/colors.dart';
import '../../service_locator.dart';

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
        title: Text('GitHub Users'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Search by',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Location'),
                  selected: _isLocationSearch,
                  onSelected: (selected) {
                    setState(() {
                      _isLocationSearch = true;
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Username'),
                  selected: !_isLocationSearch,
                  onSelected: (selected) {
                    setState(() {
                      _isLocationSearch = false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
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
                                    create: (_) =>  GetIt.instance<UserDetailProvider>()..fetchUserDetail(user.login),
                                    child: UserProfileScreen(),
                                     //child: UserProfileScreen(user: user),
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