// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/user_detail_provider.dart';
// import '../../domain/entities/user.dart';
// import 'package:share/share.dart';
// import '../colors/colors.dart';
// // import 'package:share_plus/share_plus.dart';
//
// class UserProfileScreen extends StatelessWidget {
//   final User user;
//
//   const UserProfileScreen({super.key, required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserDetailProvider>(
//         builder: (context, userDetailProvider, child) {
//           if (userDetailProvider.isLoading) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(user.login),
//                 backgroundColor: AppColors.primaryColor,
//               ),
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (userDetailProvider.user == null) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(user.login),
//                 backgroundColor: AppColors.primaryColor,
//               ),
//               body: Center(child: Text("Failed to load user details")),
//             );
//           } else {
//             final userDetail = userDetailProvider.user!;
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(userDetail.login),
//                 backgroundColor: AppColors.primaryColor,
//                 // actions: [
//                 //   IconButton(
//                 //     icon: Icon(Icons.share),
//                 //     onPressed: () {
//                 //       Share.share('Check out this GitHub user: ${userDetail.htmlUrl}');
//                 //     },
//                 //   ),
//                 // ],
//               //   actions: [
//               //     IconButton(
//               //       icon: Icon(Icons.share),
//               //       onPressed: () => _shareUserProfile(userDetail),
//               //     ),
//               //   ],
//                 actions: [
//                   IconButton(
//                     icon: Icon(Icons.share),
//                     onPressed: () {
//                       Share.share('Check out this GitHub user: ${userDetail.login} - ${userDetail.avatarUrl}');
//                     },
//                   ),
//                 ],
//                ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(userDetail.avatarUrl),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       userDetail.name,
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),
//                     Text(userDetail.bio ?? 'No bio available'),
//                     Text(userDetail.type),
//                     SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           children: [
//                             Text('Followers',
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             Text(userDetail.followers.toString()),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text('Following',
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             Text(userDetail.following.toString()),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_detail_provider.dart';
import '../../domain/entities/user.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../colors/colors.dart';

class UserProfileScreen extends StatelessWidget {
 // final User user;

  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailProvider>(
      builder: (context, userDetailProvider, child) {
        if (userDetailProvider.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              backgroundColor: AppColors.primaryColor,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (userDetailProvider.user == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              backgroundColor: AppColors.primaryColor,
            ),
            body: Center(child: Text("Failed to load user details")),
          );
        } else {
          final userDetail = userDetailProvider.user!;
          return Scaffold(
            appBar: AppBar(
              title: Text(userDetail.login),
              backgroundColor: AppColors.primaryColor,
              actions: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share('Check out this GitHub user: ${userDetail.login} - ${userDetail.avatarUrl}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.open_in_browser),
                  onPressed: () async {
                    final url = 'https://github.com/${userDetail.login}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not open the browser')),
                      );
                    }
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userDetail.avatarUrl),
                  ),
                  SizedBox(height: 16),
                  Text(
                    userDetail.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(userDetail.bio ?? 'No bio available'),
                  Text(userDetail.type),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Followers',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userDetail.followers.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Following',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userDetail.following.toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final url = 'https://github.com/${userDetail.login}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not open the browser')),
                        );
                      }
                    },
                    icon: Icon(Icons.open_in_browser),
                    label: Text('Open GitHub Profile'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
