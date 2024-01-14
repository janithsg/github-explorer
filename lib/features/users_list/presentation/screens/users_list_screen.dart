import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_users_viewer/core/widgets/app_bar/custom_appbar.dart';
import 'package:gh_users_viewer/features/users_list/bloc/users_list_bloc.dart';
import 'package:gh_users_viewer/features/users_list/data/repository/users_list_repository.dart';
import 'package:gh_users_viewer/features/users_list/presentation/widgets/single_list_item.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  UsersListRepository repository = UsersListRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Explore GitHub",
        trailing: [
          IconButton(
            onPressed: () {
              repository.getUsersList(since: 1, perPage: 30);
            },
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
                      BlocProvider.of<UsersListBloc>(context).add(
                        PaginateUsersListEvent(since: state.lastId),
                      );
                    }
                  }
                  return false;
                },
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index < state.usersList.length) {
                      return SingleListItem(
                        userData: state.usersList[index],
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
    );
  }
}
