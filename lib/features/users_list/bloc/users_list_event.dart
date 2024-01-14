part of 'users_list_bloc.dart';

sealed class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialDataEvent extends UsersListEvent {}

class PaginateUsersListEvent extends UsersListEvent {
  final int since;

  const PaginateUsersListEvent({
    required this.since,
  });
}
