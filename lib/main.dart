import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gh_users_viewer/gh_users_viewer_app.dart';

void main() {
  configLoadingIndicator();

  runApp(const GithubUsersViewerApp());
}

void configLoadingIndicator() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = false;
}
