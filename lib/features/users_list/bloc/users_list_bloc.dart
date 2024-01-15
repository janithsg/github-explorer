import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_users_viewer/core/constants/enums.dart';
import 'package:gh_users_viewer/core/networking/exceptions/custom_exception.dart';
import 'package:gh_users_viewer/features/user_details/data/model/user_details_model.dart';
import 'package:gh_users_viewer/features/users_list/data/model/users_list_item.dart';
import 'package:gh_users_viewer/features/users_list/data/repository/users_list_repository.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final _usersListRepository = UsersListRepository();

  UsersListBloc() : super(const UsersListState.initial()) {
    on<LoadInitialDataEvent>(_onLoadInitialUsersList);
    on<PaginateUsersListEvent>(_onPaginateUsersList);
    on<GetUserDetailsByUsernameEvent>(_onTapUserFromListEvent);
  }

  void _onLoadInitialUsersList(LoadInitialDataEvent event, Emitter<UsersListState> emit) async {
    try {
      List<UsersListItem>? usersList = await _usersListRepository.getUsersList(since: state.lastId, perPage: state.perPage);

      if (usersList != null && usersList.isNotEmpty) {
        emit(UsersListState.loaded(usersList, usersList.last.id));
      }
    } on FetchDataException catch (error) {
      emit(UsersListState.error(ErrorTypes.networkError, error.toString()));
    } on UnauthorisedException catch (error) {
      emit(UsersListState.error(ErrorTypes.authError, error.toString()));
    } catch (e) {
      emit(const UsersListState.error(ErrorTypes.unknownError, "Something went wrong"));
    }
  }

  void _onPaginateUsersList(PaginateUsersListEvent event, Emitter<UsersListState> emit) async {
    try {
      List<UsersListItem>? currentList = state.usersList;

      emit(UsersListState.paginating(currentList));

      List<UsersListItem>? usersList = await _usersListRepository.getUsersList(since: event.since, perPage: state.perPage);

      // Update current list
      if (usersList != null) {
        currentList.addAll(usersList.toList());
      }

      if (usersList != null && usersList.isNotEmpty) {
        emit(UsersListState.paginated(currentList, false, usersList.last.id));
      } else if (usersList == null || usersList.isEmpty) {
        emit(UsersListState.paginated(currentList, true, currentList.last.id));
      }
    } on FetchDataException catch (error) {
      emit(UsersListState.error(ErrorTypes.networkError, error.toString()));
    } on UnauthorisedException catch (error) {
      emit(UsersListState.error(ErrorTypes.authError, error.toString()));
    } catch (e) {
      emit(const UsersListState.error(ErrorTypes.unknownError, "Something went wrong"));
    }
  }

  void _onTapUserFromListEvent(GetUserDetailsByUsernameEvent event, Emitter<UsersListState> emit) async {
    List<UsersListItem>? currentList = state.usersList;

    try {
      emit(UsersListState.fetchingUserDetails(currentList));

      UserDetailsModel? userDetails = await _usersListRepository.getUserDetails(username: event.username);

      if (userDetails != null) {
        emit(UsersListState.fetchedUserDetails(currentList, userDetails));
      }
    } on DetailsNotFoundException catch (_) {
      emit(UsersListState.fetchUserDetailsError(currentList, "User details not found"));
    } on FetchDataException catch (error) {
      emit(UsersListState.error(ErrorTypes.networkError, error.toString()));
    } on UnauthorisedException catch (error) {
      emit(UsersListState.error(ErrorTypes.authError, error.toString()));
    } catch (e) {
      emit(const UsersListState.error(ErrorTypes.unknownError, "Something went wrong"));
    }
  }
}
