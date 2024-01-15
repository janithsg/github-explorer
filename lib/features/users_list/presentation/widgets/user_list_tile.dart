import 'package:flutter/material.dart';
import 'package:gh_users_viewer/features/users_list/data/model/users_list_item_model.dart';

class UserListTile extends StatelessWidget {
  final UsersListItemModel userData;
  final Function()? onTap;

  const UserListTile({
    super.key,
    required this.userData,
    required this.onTap,
  });

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
      onTap: onTap,
    );
  }
}
