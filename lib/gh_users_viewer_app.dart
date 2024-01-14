import 'package:flutter/material.dart';
import 'package:gh_users_viewer/features/users_list/bloc/users_list_provider.dart';

class GithubUsersViewerApp extends StatelessWidget {
  const GithubUsersViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersListProvider(),
    );
  }
}
