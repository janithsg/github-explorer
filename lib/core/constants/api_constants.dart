import 'package:gh_users_viewer/env/env.dart';

abstract class ApiConstants {
  static String getUsersList = '${Env.rootUrl}/users'; // GET

  static String getReposList = '${Env.rootUrl}/repos'; // GET
}
