import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_users_viewer/core/constants/enums.dart';
import 'package:gh_users_viewer/core/networking/exceptions/custom_exception.dart';
import 'package:gh_users_viewer/features/users_list/data/model/users_list_item.dart';
import 'package:gh_users_viewer/features/users_list/data/repository/users_list_repository.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final _usersListRepository = UsersListRepository();

  UsersListBloc() : super(const UsersListState.loading()) {
    on<LoadUsersListEvent>(_onLoadUsersList);
  }

  void _onLoadUsersList(LoadUsersListEvent event, Emitter<UsersListState> emit) async {
    try {
      List<UsersListItem>? usersList = await _usersListRepository.getUsersList(since: event.since, perPage: event.perPage);

      if (usersList != null) {
        emit(UsersListState.loaded(usersList));
      }
    } on FetchDataException catch (error) {
      log("error1");
      emit(UsersListState.error(ErrorTypes.networkError, error.toString()));
    } on UnauthorisedException catch (error) {
      log("error2");
      emit(UsersListState.error(ErrorTypes.authError, error.toString()));
    } catch (e) {
      log("error3");
      emit(const UsersListState.error(ErrorTypes.unknownError, "Something went wrong"));
    }
  }
}
