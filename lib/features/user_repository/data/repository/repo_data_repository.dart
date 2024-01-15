import 'package:gh_users_viewer/core/constants/api_constants.dart';
import 'package:gh_users_viewer/core/constants/enums.dart';
import 'package:gh_users_viewer/core/networking/api_client.dart';
import 'package:gh_users_viewer/features/user_repository/data/model/repository_list_item.dart';

class RepoDataRepository {
  final _apiClient = ApiClient();

  Future<List<RepositoryListItem>?> getReposListOfUser({required String username, required int page, required int perPage}) async {
    // Get url
    String url = "${ApiConstants.getUsersList}/$username/repos";

    // Build pagination headers
    Map<String, dynamic>? params = {
      "page": page.toString(),
      "per_page": perPage.toString(),
    };

    final resData = await _apiClient.makeAuthorizedApiRequest(
      method: HttpMethods.get,
      url: url,
      params: params,
      body: {},
      headers: {},
    );

    List<RepositoryListItem>? reposList = RepositoryListItem.fromJsonArray(resData);

    // Fetch languages of each repo
    await Future.forEach<RepositoryListItem>(reposList, (repoItem) async {
      repoItem.languageList = await getLanguagesOfRepos(repoName: repoItem.fullName!);
    });

    return reposList;
  }

  Future<List<String>> getLanguagesOfRepos({required String repoName}) async {
    // Get url
    String url = "${ApiConstants.getReposList}/$repoName/languages";

    final resData = await _apiClient.makeAuthorizedApiRequest(
      method: HttpMethods.get,
      url: url,
      params: {},
      body: {},
      headers: {},
    );

    return resData.keys.toList();
  }
}
