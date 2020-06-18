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
      default:
        return null;
    }

  }

  static MaterialPageRoute _buildMaterialRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(settings: settings, builder: (BuildContext context) => builder);
  }

  static Route _buildRoute(RouteSettings settings, Widget builder) {
//    return FadeRoute(builder);
    return CupertinoPageRoute(settings: settings, builder: (BuildContext context) => builder);
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute(this.page)
      : super(
    pageBuilder: (
        context,
        animation,
        secondaryAnimation,
        ) {
      return page;
    },
    transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
        ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;

  EnterExitRoute(this.enterPage, this.exitPage)
      : super(
    pageBuilder: (
        context,
        animation,
        secondaryAnimation,
        ) {
      return exitPage;
    },
    transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
        ) =>
        Stack(
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 0.0),
                end: Offset(-1.0, 0.0),
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeIn),
              ),
              child: enterPage,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: exitPage,
            )
          ],
        ),
  );
}