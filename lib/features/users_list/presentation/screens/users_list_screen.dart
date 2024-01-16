import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gh_users_viewer/core/widgets/app_bar/custom_appbar.dart';
import 'package:gh_users_viewer/features/user_repository/bloc/repo_data_provider.dart';
import 'package:gh_users_viewer/features/users_list/bloc/users_list_bloc.dart';
import 'package:gh_users_viewer/features/users_list/data/repository/users_list_repository.dart';
import 'package:gh_users_viewer/features/users_list/presentation/widgets/find_user_alert.dart';
import 'package:gh_users_viewer/features/users_list/presentation/widgets/user_list_tile.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  UsersListRepository repository = UsersListRepository();

  late UsersListBloc _usersListBloc;

  @override
  void initState() {
    super.initState();
    _usersListBloc = BlocProvider.of<UsersListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersListBloc, UsersListState>(
          listenWhen: (previous, current) => current.userDetails != null,
          listener: (context, state) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RepoDataProvider(user: state.userDetails!),
              ),
            );
          },
        ),
        BlocListener<UsersListBloc, UsersListState>(
          listenWhen: (previous, current) => previous.isFetchingUserDetails != current.isFetchingUserDetails,
          listener: (context, state) {
            if (state.isFetchingUserDetails == true) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Explore GitHub",
          trailing: [
            IconButton(
              onPressed: _showSearchPopup,
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<UsersListBloc, UsersListState>(
            builder: (context, state) {
              if (state.isError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Oops..",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        state.errorMsg,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                      if (!state.isPaginating) {
                        _usersListBloc.add(
                          PaginateUsersListEvent(since: state.lastId),
                        );
                      }
                    }
                    return false;
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index < state.usersList.length) {
                        return UserListTile(
                          userData: state.usersList[index],
                          onTap: () {
                            _usersListBloc.add(
                              GetUserDetailsByUsernameEvent(username: state.usersList[index].login),
                            );
                          },
                        );
                      } else {
                        return const ListTile(
                          title: SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.blueGrey,
                        thickness: 0.2,
                      );
                    },
                    itemCount: state.usersList.length + 1,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showSearchPopup() async {
    await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: _usersListBloc,
          child: const FindUserAlert(),
        );
      },
      barrierDismissible: false,
    );
  }
}
