import 'package:RoFSplit/rof_detail_page.dart';
import 'package:RoFSplit/rof_info.dart';
import 'package:RoFSplit/rof_master_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoFRouter {
  static Route route(RouteSettings settings) {
    debugPrint('rof router route, setting $settings');
    var arguments = settings.arguments;
    String name = settings.name;
    switch (name) {
      case '/rof/master/root' :
        return _buildRoute(settings, RoFSplitMasterPage(navigatorState: RoFInfo.kRoFSplitNavigatorStateDetail,));
      case '/rof/detail/root' :
        return _buildRoute(settings, RoFSplitDetailPage(navigatorState: RoFInfo.kRoFSplitNavigatorStateDetail, title: '0',));
      case '/rof/wkwebview' :
        return _buildRoute(settings, Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 2,
                child: UiKitView(
                  viewType: 'MyUiKitView',
                ),
              ),
            ],
          ),
        ));
      case '/rof/rnview' :
        return _buildRoute(settings, RoFSplitDetailPage(navigatorState: RoFInfo.kRoFSplitNavigatorStateDetail, title: '0',));
      default:
        return null;
    }

  }

  static NavigatorState currentNavigatorState() {
    return RoFInfo.kRoFSplitNavigatorStateDetail.currentState;
  }

  static MaterialPageRoute _buildMaterialRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(settings: settings, builder: (BuildContext context) => builder);
  }

  static Route _buildRoute(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(settings: settings, builder: (BuildContext context) => builder);
  }
}