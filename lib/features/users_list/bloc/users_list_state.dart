part of 'users_list_bloc.dart';

class UsersListState extends Equatable {
  final List<UsersListItemModel> usersList;
  final int lastId;
  final int perPage;
  final bool isLoading;
  final bool isPaginating;
  final bool isError;
  final ErrorTypes errorType;
  final String errorMsg;
  final bool donePaginating;
  final bool isFetchingUserDetails;
  final UserDetailsModel? userDetails;
  final bool isUserDetailsError;
  final String userDetailsErrorMsg;

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
    this.isFetchingUserDetails = false,
    this.userDetails,
    this.isUserDetailsError = false,
    this.userDetailsErrorMsg = "",
  });

  const UsersListState.initial() : this._(isLoading: true, lastId: 0);

  const UsersListState.loaded(List<UsersListItemModel> list, int lastId)
      : this._(
          usersList: list,
          isLoading: false,
          isPaginating: false,
          lastId: lastId,
        );

  const UsersListState.paginating(
    List<UsersListItemModel> list,
  ) : this._(
          usersList: list,
          isPaginating: true,
        );

  const UsersListState.paginated(List<UsersListItemModel> list, bool donePaginated, int lastId)
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

  const UsersListState.fetchingUserDetails(
    List<UsersListItemModel> list,
  ) : this._(
          usersList: list,
          isFetchingUserDetails: true,
        );

  const UsersListState.fetchedUserDetails(
    List<UsersListItemModel> list,
    UserDetailsModel userDetailsModel,
  ) : this._(
          usersList: list,
          userDetails: userDetailsModel,
        );

  const UsersListState.fetchUserDetailsError(
    List<UsersListItemModel> list,
    String fetchingError,
  ) : this._(
          usersList: list,
          isUserDetailsError: true,
          userDetailsErrorMsg: fetchingError,
        );

  @override
  List<Object> get props => [
        usersList,
        isLoading,
        isPaginating,
        isError,
        errorType,
        errorMsg,
        donePaginating,
        isFetchingUserDetails,
      ];
}
