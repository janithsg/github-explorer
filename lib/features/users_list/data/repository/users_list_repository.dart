import 'package:gh_users_viewer/core/constants/api_constants.dart';
import 'package:gh_users_viewer/core/constants/enums.dart';
import 'package:gh_users_viewer/core/networking/api_client.dart';
import 'package:gh_users_viewer/features/users_list/data/model/users_list_item.dart';

class UsersListRepository {
  final _apiClient = ApiClient();

  Future<List<UsersListItem>?> getUsersList({required int since, required int perPage}) async {
    // Get url
    String url = ApiConstants.getUsersList;

    // Build pagination headers
    {
      Map<String, dynamic>? params = {
        "since": since.toString(),
        "per_page": perPage.toString(),
      };

      final resData = await _apiClient.makeAuthorizedApiRequest(
        method: HttpMethods.get,
        url: url,
        params: params,
        body: {},
        headers: {},
      );

      List<UsersListItem>? usersList = UsersListItem.fromJsonArray(resData);

      return usersList;
    }
  }
}
