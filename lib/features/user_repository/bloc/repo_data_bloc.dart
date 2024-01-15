import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_users_viewer/core/networking/exceptions/custom_exception.dart';
import 'package:gh_users_viewer/features/user_repository/data/model/repository_list_item.dart';
import 'package:gh_users_viewer/features/user_repository/data/repository/repo_data_repository.dart';

part 'repo_data_event.dart';
part 'repo_data_state.dart';

class RepoDataBloc extends Bloc<RepoDataEvent, RepoDataState> {
  final _repoDataRepository = RepoDataRepository();

  RepoDataBloc() : super(const RepoDataState.initial()) {
    on<LoadInitialRepoListEvent>(_onLoadInitialReposList);
    on<PaginateRepoListEvent>(_onPaginateReposList);
  }

  void _onLoadInitialReposList(LoadInitialRepoListEvent event, Emitter<RepoDataState> emit) async {
    try {
      List<RepositoryListItem>? reposList = await _repoDataRepository.getReposListOfUser(
        username: event.username,
        page: 1,
        perPage: state.perPage,
      );

      if (reposList != null && reposList.isNotEmpty) {
        emit(RepoDataState.loaded(reposList));
      }
    } on FetchDataException catch (_) {
    } on UnauthorisedException catch (_) {
    } catch (_) {}
  }

  void _onPaginateReposList(PaginateRepoListEvent event, Emitter<RepoDataState> emit) async {
    try {
      List<RepositoryListItem>? currentList = state.repoList;
      int currentPage = state.page;

      emit(RepoDataState.paginating(currentList));

      List<RepositoryListItem>? reposList = await _repoDataRepository.getReposListOfUser(
        username: event.username,
        page: currentPage + 1,
        perPage: state.perPage,
      );

      if (reposList != null) {
        currentList.addAll(reposList.toList());
      }

      if (reposList != null && reposList.isNotEmpty) {
        emit(RepoDataState.paginated(currentList, currentPage + 1));
      }
    } on FetchDataException catch (_) {
    } on UnauthorisedException catch (_) {
    } catch (_) {}
  }
}
