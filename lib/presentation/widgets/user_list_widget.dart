// presentation/widgets/user_list_widget.dart
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../screens/user_profile_screen.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;

  UserListWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: Image.network(user.avatarUrl),
          title: Text(user.name),
          subtitle: Text(user.login),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(),
              ),
            );
          },
        );
      },
    );
  }
}


