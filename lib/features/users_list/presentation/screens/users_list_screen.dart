import 'package:flutter/material.dart';
import 'package:gh_users_viewer/core/widgets/app_bar/custom_appbar.dart';
import 'package:gh_users_viewer/features/users_list/presentation/widgets/single_list_item.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Explore GitHub",
        trailing: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return const SingleListItem();
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.blueGrey,
                thickness: 0.2,
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}
