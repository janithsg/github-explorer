import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_users_viewer/features/user_repository/bloc/repo_data_bloc.dart';
import 'package:gh_users_viewer/features/user_repository/data/model/user_details_model.dart';
import 'package:gh_users_viewer/features/user_repository/presentation/screens/user_repository_screen.dart';

class RepoDataProvider extends BlocProvider<RepoDataBloc> {
  final UserDetailsModel user;

  RepoDataProvider({
    super.key,
    required this.user,
  }) : super(
          create: (context) => RepoDataBloc(),
          child: UserDetailsScreen(
            userDetails: user,
          ),
        );
}
