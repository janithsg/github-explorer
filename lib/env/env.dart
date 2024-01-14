import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev')
abstract class Env {
  @EnviedField(varName: 'GITHUB_PAT')
  static String githubPAT = _Env.githubPAT;
  @EnviedField(varName: 'API_ROOT')
  static String rootUrl = _Env.rootUrl;
}
