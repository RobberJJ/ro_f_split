import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:RoFSplit/RoFSplit.dart';
import 'package:RoFSplit/rof_split_navigator.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef void WebViewCreatedCallback(WebViewController controller);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  WebViewCreatedCallback onWebViewCreated;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
//      platformVersion = await RoFSplit.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void _onPlatformViewCreated(int id) {
    if (onWebViewCreated == null) {
      return;
    }
    onWebViewCreated(new WebViewController(id));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
//      Scaffold(
//        appBar: AppBar(
//          title: Text('webview demo'),
//        ),
////        body: UiKitView(
////          viewType: 'MyUiKitView',
////        ),
//        body: WebView(
//          initialUrl: "https://baidu.com",
//        ),
//      ),
      Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
        body: RoFSplit(
          masterWidth: 220,
          master: RoFSplitNavigator(
            navigatorKey: RoFInfo.kRoFSplitNavigatorStateMaster,
            initialRoute: '/rof/master/root',
            onGenerateRoute: RoFRouter.route,
          ),
          detail: RoFSplitNavigator(
            navigatorKey: RoFInfo.kRoFSplitNavigatorStateDetail,
            initialRoute: '/rof/wkwebview',
            onGenerateRoute: RoFRouter.route,
          ),
        ),
      ),
    );
  }
}

class WebViewController {
  WebViewController(int id) {
    this._channel = new MethodChannel('webview$id');
  }

  MethodChannel _channel;

  Future<void> loadUrl(String url) async {
    return _channel.invokeMethod('loadUrl', url);
  }
}
