import 'dart:convert';

import 'package:gh_users_viewer/core/constants/enums.dart';
import 'package:gh_users_viewer/core/networking/exceptions/custom_exception.dart';
import 'package:gh_users_viewer/env/env.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  // This method make the API call with access token
  Future<dynamic> makeAuthorizedApiRequest({
    required HttpMethods method,
    required String url,
    required Map<String, dynamic>? params,
    required Map<String, dynamic>? body,
    required Map<String, String> headers,
  }) async {
    // Build Uri
    Uri apiPath = Uri.parse(url).replace(queryParameters: params);

    // Set access token and relavant headers
    Map<String, String> headers = {};
    headers.addEntries({"Content-Type": "application/json"}.entries);
    headers.addEntries({"Authorization": "Bearer ${Env.githubPAT}"}.entries);
    headers.addEntries({"X-GitHub-Api-Version": Env.apiVersion}.entries);

    if (method == HttpMethods.get) {
      return _makeGetRequest(uri: apiPath, headers: headers);
    } else {
      return null;
    }
  }

  Future<dynamic> _makeGetRequest({required Uri uri, Map<String, String>? headers}) async {
    // Make API Call
    final response = await http.get(
      uri,
      headers: headers,
    );

    // Build Response JSON
    dynamic responseJson = _handleApiResponse(response);

    return responseJson;
  }

  dynamic _handleApiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 404:
        dynamic responseAsJson = json.decode(response.body);
        return responseAsJson;
      case 401:
      case 403:
        throw UnauthorisedException("Access token is invalid");
      default:
        throw FetchDataException("Something went wrong");
    }
  }
}
