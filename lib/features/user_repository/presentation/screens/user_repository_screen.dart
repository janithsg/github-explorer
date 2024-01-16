import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_users_viewer/core/widgets/app_bar/custom_appbar.dart';
import 'package:gh_users_viewer/features/user_repository/bloc/repo_data_bloc.dart';
import 'package:gh_users_viewer/features/user_repository/data/model/user_details_model.dart';
import 'package:gh_users_viewer/features/user_repository/presentation/screens/repo_webview_screen.dart';
import 'package:gh_users_viewer/features/user_repository/presentation/widgets/repo_list_tile.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserDetailsModel userDetails;

  const UserDetailsScreen({super.key, required this.userDetails});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RepoDataBloc>(context).add(
      LoadInitialRepoListEvent(username: widget.userDetails.login!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: "",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: BlocBuilder<RepoDataBloc, RepoDataState>(
              builder: (context, state) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                      if (!state.isPaginating) {
                        BlocProvider.of<RepoDataBloc>(context).add(
                          PaginateRepoListEvent(username: widget.userDetails.login!),
                        );
                      }
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Image.network(widget.userDetails.avatarUrl!),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.userDetails.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "@${widget.userDetails.login!}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(thickness: 0.4),
                        _buildFollowCounts(),
                        const Divider(thickness: 0.4),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Repositories",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        _buildRepositoryList(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRepositoryList() {
    return BlocBuilder<RepoDataBloc, RepoDataState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < state.repoList.length) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RepoWebviewScreen(
                        repoName: state.repoList[index].fullName!,
                        url: state.repoList[index].htmlUrl!,
                      ),
                    ),
                  );
                },
                child: RepoListTile(
                  listItem: state.repoList[index],
                ),
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
              thickness: 0.3,
            );
          },
          itemCount: state.repoList.length + 1,
        );
      },
    );
  }

  Widget _buildFollowCounts() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                widget.userDetails.followers.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Followers",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                widget.userDetails.following.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Following",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
