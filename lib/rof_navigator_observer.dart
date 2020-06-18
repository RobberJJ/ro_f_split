import 'package:RoFSplit/rof_info.dart';
import 'package:flutter/cupertino.dart';

typedef RoFRefreshCallback = void Function();

class RoFNavigatorObserver extends NavigatorObserver {
  final RoFRefreshCallback onRefresh;
  RoFNavigatorObserver({
    this.onRefresh,
  });
  @override
  void didPop(Route route, Route previousRoute) {
    if (previousRoute.isFirst != RoFInfo.isRootForDetail) {
      RoFInfo.isRootForDetail = previousRoute.isFirst;
      if (onRefresh != null) onRefresh();
    }
    debugPrint('did pop : pre $previousRoute new $route');
//    debugPrint('${this.navigator == RoFInfo.kRoFSplitNavigatorStateDetail.currentState}');
//    debugPrint('${this.navigator == RoFInfo.kRoFSplitNavigatorStateMaster.currentState}');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (route.isFirst != RoFInfo.isRootForDetail) {
      RoFInfo.isRootForDetail = route.isFirst;
      if (onRefresh != null) onRefresh();
    }
    debugPrint('did push : pre $previousRoute new $route');
    debugPrint('${this.navigator == RoFInfo.kRoFSplitNavigatorStateDetail.currentState}');
    debugPrint('${this.navigator == RoFInfo.kRoFSplitNavigatorStateMaster.currentState}');
    super.didPush(route, previousRoute);
  }
}
