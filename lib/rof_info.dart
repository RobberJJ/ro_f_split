import 'package:flutter/cupertino.dart';

final Map<String, Map> _navigatorStateKeys = {};

enum RoFSplitNavigatorStateKeyType {
  /// master 区域 navigator state
  master,
  /// detail 区域 navigator state
  detail,

}

class RoFInfo {
  static final GlobalKey<NavigatorState> kRoFSplitNavigatorStateMaster  = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> kRoFSplitNavigatorStateDetail  = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> generateNavigatorKey(String signKey, {RoFSplitNavigatorStateKeyType type = RoFSplitNavigatorStateKeyType.detail}) {
    if(null == signKey){
      return null;
    }

    if(null != _navigatorStateKeys[signKey] && null != _navigatorStateKeys[signKey][type]){
      return _navigatorStateKeys[signKey][type];
    }

    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    Map keyMap = _navigatorStateKeys[signKey] ?? {};
    keyMap[type] = navigatorKey;
    _navigatorStateKeys[signKey] = keyMap;
    return navigatorKey;
  }

  ///当前App所占屏幕宽度
  static double windowWidth = 0.0;
  ///当前App所占屏幕高度
  static double windowHeight = 0.0;
  ///屏幕宽度
  static double screenWidth = 0.0;
  ///屏幕高度
  static double screenHeight = 0.0;
  ///屏幕密度
  static double devicePixelRatio = 1.0;
  ///判断是否是iPad
  static bool isIpad = false;
  ///判断当前状态是否可分屏
  static bool get isSplit => _isSplit();
  ///split master width
  static double get masterWidth => _masterWidth();
  ///detail route count is 1 or not.
  static bool isRootForDetail = true;

  ///iPad判断私有方法
  static bool _isSplit() {
    return isIpad && (screenWidth > screenHeight) && (screenWidth > 0) && (windowWidth / screenWidth > 0.5);
  }

  ///获取split master width，规则 [screenWidth] 的1/3，不可分屏状态下为 0
  static double _masterWidth() {
    return isSplit ? (screenWidth / 3) : (isRootForDetail ? windowWidth : 0);
  }
}