part of 'repo_data_bloc.dart';

sealed class RepoDataEvent extends Equatable {
  const RepoDataEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialRepoListEvent extends RepoDataEvent {
  final String username;

  const LoadInitialRepoListEvent({
    required this.username,
  });
}

class PaginateRepoListEvent extends RepoDataEvent {
  final String username;

  const PaginateRepoListEvent({
    required this.username,
  });
}
