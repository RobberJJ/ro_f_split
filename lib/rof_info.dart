import 'package:flutter/cupertino.dart';

class RoFInfo {
  static final GlobalKey<NavigatorState> kRoFSplitNavigatorStateMaster  = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> kRoFSplitNavigatorStateDetail  = GlobalKey<NavigatorState>();

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
    return isIpad && (windowWidth > windowHeight) && (screenWidth > 0) && (windowWidth / screenWidth > 0.5);
  }

  ///获取split master width，规则 [screenWidth] 的1/3，不可分屏状态下为 0
  static double _masterWidth() {
    return isSplit ? (screenWidth / 3) : (isRootForDetail ? windowWidth : 0);
  }
}