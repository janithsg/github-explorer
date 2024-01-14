part of 'users_list_bloc.dart';

class UsersListState extends Equatable {
  final List<UsersListItem> usersList;
  final bool isLoading;
  final bool isPaginating;
  final bool isError;
  final ErrorTypes errorType;
  final String errorMsg;

  const UsersListState._({
    this.isLoading = true,
    this.isPaginating = false,
    this.usersList = const [],
    this.isError = false,
    this.errorType = ErrorTypes.none,
    this.errorMsg = "",
  });

  const UsersListState.loading() : this._(isLoading: true);

  const UsersListState.loaded(List<UsersListItem> list)
      : this._(
          usersList: list,
          isLoading: false,
          isPaginating: false,
        );

  const UsersListState.paginating() : this._(isPaginating: true);

  const UsersListState.paginated(List<UsersListItem> list)
      : this._(
          usersList: list,
          isPaginating: false,
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
