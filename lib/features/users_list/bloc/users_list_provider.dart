import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_users_viewer/features/users_list/bloc/users_list_bloc.dart';
import 'package:gh_users_viewer/features/users_list/presentation/screens/users_list_screen.dart';

class UsersListProvider extends BlocProvider<UsersListBloc> {
  UsersListProvider({
    super.key,
  }) : super(
          create: (context) => UsersListBloc()
            ..add(
              const LoadUsersListEvent(since: 1, perPage: 30),
            ),
          child: const UsersListScreen(),
        );
}
