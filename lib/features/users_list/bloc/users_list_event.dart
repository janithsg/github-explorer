part of 'users_list_bloc.dart';

sealed class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersListEvent extends UsersListEvent {
  final int since;
  final int perPage;

  const LoadUsersListEvent({
    required this.since,
    required this.perPage,
  });
}
