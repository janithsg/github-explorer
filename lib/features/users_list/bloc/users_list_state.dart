part of 'users_list_bloc.dart';

class UsersListState extends Equatable {
  final List<UsersListItem> usersList;
  final int lastId;
  final int perPage;
  final bool isLoading;
  final bool isPaginating;
  final bool isError;
  final ErrorTypes errorType;
  final String errorMsg;
  final bool donePaginating;

  const UsersListState._({
    this.isLoading = false,
    this.isPaginating = false,
    this.usersList = const [],
    this.lastId = 0,
    this.perPage = 30,
    this.isError = false,
    this.errorType = ErrorTypes.none,
    this.errorMsg = "",
    this.donePaginating = false,
  });

  const UsersListState.initial() : this._(isLoading: true, lastId: 0);

  const UsersListState.loaded(List<UsersListItem> list, int lastId)
      : this._(
          usersList: list,
          isLoading: false,
          isPaginating: false,
          lastId: lastId,
        );

  const UsersListState.paginating(
    List<UsersListItem> list,
  ) : this._(
          usersList: list,
          isPaginating: true,
        );

  const UsersListState.paginated(List<UsersListItem> list, bool donePaginated, int lastId)
      : this._(
          usersList: list,
          isPaginating: false,
          donePaginating: donePaginated,
          lastId: lastId,
        );

  const UsersListState.error(ErrorTypes errorType, String message)
      : this._(
          isError: true,
          errorType: errorType,
          errorMsg: message,
          isLoading: false,
          isPaginating: false,
        );

  @override
  List<Object> get props => [
        usersList,
        isLoading,
        isPaginating,
        isError,
        errorType,
      ];
}
