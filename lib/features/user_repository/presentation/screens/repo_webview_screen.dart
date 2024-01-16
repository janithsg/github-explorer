import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gh_users_viewer/core/widgets/app_bar/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepoWebviewScreen extends StatefulWidget {
  final String repoName;
  final String url;

  const RepoWebviewScreen({
    super.key,
    required this.repoName,
    required this.url,
  });

  @override
  State<RepoWebviewScreen> createState() => _RepoWebviewScreenState();
}

class _RepoWebviewScreenState extends State<RepoWebviewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log(progress.toString());
            EasyLoading.showProgress(progress / 100);
          },
          onPageFinished: (String url) {
            EasyLoading.dismiss();
          },
          onWebResourceError: (WebResourceError error) {
            Navigator.of(context).pop();
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: widget.repoName,
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
