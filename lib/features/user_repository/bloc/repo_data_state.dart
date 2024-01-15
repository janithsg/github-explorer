part of 'repo_data_bloc.dart';

class RepoDataState extends Equatable {
  final List<RepositoryListItem> repoList;
  final bool isLoading;
  final bool isPaginating;
  final int page;
  final int perPage;

  const RepoDataState._({
    this.repoList = const [],
    this.isLoading = false,
    this.isPaginating = false,
    this.page = 1,
    this.perPage = 5,
  });

  const RepoDataState.initial() : this._(isLoading: true);

  const RepoDataState.loaded(
    List<RepositoryListItem> repoList,
  ) : this._(
          isLoading: false,
          repoList: repoList,
        );

  const RepoDataState.paginating(
    List<RepositoryListItem> repoList,
  ) : this._(
          isPaginating: true,
          repoList: repoList,
        );

  const RepoDataState.paginated(
    List<RepositoryListItem> repoList,
    int page,
  ) : this._(
          isPaginating: false,
          repoList: repoList,
          page: page,
        );

  @override
  List<Object> get props => [
        repoList,
        isLoading,
        isPaginating,
        page,
        perPage,
      ];
}
