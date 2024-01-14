part of 'users_list_bloc.dart';

sealed class UsersListState extends Equatable {
  const UsersListState();
  
  @override
  List<Object> get props => [];
}

final class UsersListInitial extends UsersListState {}
