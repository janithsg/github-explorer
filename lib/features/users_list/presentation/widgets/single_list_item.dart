import 'package:flutter/material.dart';
import 'package:gh_users_viewer/features/users_list/data/model/users_list_item.dart';

class SingleListItem extends StatelessWidget {
  final UsersListItem userData;

  const SingleListItem({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Image.network(userData.avatarUrl),
      ),
      title: Text(
        userData.login,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {},
    );
  }
}
