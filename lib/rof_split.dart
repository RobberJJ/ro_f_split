import 'dart:ui';
import 'package:RoFDevice/RoFDevice.dart';
import 'package:RoFSplit/rof_detail_page.dart';
import 'package:RoFSplit/rof_info.dart';
import 'package:RoFSplit/rof_master_page.dart';
import 'package:RoFSplit/rof_navigator_observer.dart';
import 'package:RoFSplit/rof_router.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoFSplit extends StatefulWidget {
  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String masterRootRouteName;

  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String detailRootRouteName;

  /// Called to generate a route for a given [RouteSettings].
  final RouteFactory onGenerateRoute;

  /// The application's top-level routing table.
  ///
  /// When a named route is pushed with [Navigator.pushNamed], the route name is
  /// looked up in this map. If the name is present, the associated
  /// [WidgetBuilder] is used to construct a [MaterialPageRoute] that performs
  /// an appropriate transition, including [Hero] animations, to the new route.
  ///
  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder> routes;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory onUnknownRoute;

  const RoFSplit({
    Key key,
    this.masterRootRouteName = '/rof/master/root',
    this.detailRootRouteName = '/rof/detail/root',
    this.onGenerateRoute = RoFRouter.route,
    this.routes = const <String, WidgetBuilder>{},
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
  }) : super(key: key);

  @override
  _RoFSplitState createState() => _RoFSplitState();
}

class _RoFSplitState extends State<RoFSplit> with WidgetsBindingObserver {
  final ScreenEmptyWidget emptyMaster = ScreenEmptyWidget();

  bool isSplitLast;

  RoFNavigatorObserver _navigatorObserver;
  List<NavigatorObserver> navigatorObservers = <NavigatorObserver>[];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    navigatorObservers.addAll(widget.navigatorObservers);
    _navigatorObserver = RoFNavigatorObserver(onRefresh: _onRefresh);
    navigatorObservers.add(_navigatorObserver);
    super.initState();

    debugPrint('onRefresh init');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    RoFInfo.devicePixelRatio = window.devicePixelRatio;
    RoFInfo.windowWidth = window.physicalSize.width / RoFInfo.devicePixelRatio;
    RoFInfo.windowHeight = window.physicalSize.height / RoFInfo.devicePixelRatio;
    debugPrint(
        'window width: ${RoFInfo.windowWidth}  height: ${RoFInfo.windowHeight} devicePixelRatio : ${window.devicePixelRatio}');
    RoFDevice().deviceInfo.then((value) {
      if (value is RoFDeviceInfoIos) {
        RoFInfo.screenWidth = value.screenWidth;
        RoFInfo.screenHeight = value.screenHeight;
        RoFInfo.isIpad = value.deviceType == 'ipad';
        debugPrint(
            'device info: device type ${value.deviceType} SW ${value.screenWidth} SH ${value.screenHeight}');
        if (isSplitLast != RoFInfo.isSplit) {
          this.setState(() {
            isSplitLast = RoFInfo.isSplit;
          });
        }
      } else {
        RoFInfo.isIpad = false;
      }
    });

    super.didChangeMetrics();
  }

  void _onRefresh() {
    debugPrint('onRefresh');
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    //if (!(!RoFInfo.isSplit && RoFInfo.isRootForDetail))
    children.add(_detail());
    if (RoFInfo.isSplit || RoFInfo.isRootForDetail) children.add(_master());
    debugPrint('children $children');
    return Stack(
      children: children,
    );
  }

  Widget _master() {
    List<Widget> children = <Widget>[];
    debugPrint("111111111111 ${RoFInfo.masterWidth} ${RoFInfo.screenWidth}");
    children.add(Container(
      width: RoFInfo.masterWidth,
      child: Container(
        color: Colors.blue,
        child: CustomNavigator(
          navigatorKey: RoFInfo.kRoFSplitNavigatorStateMaster,
          initialRoute: widget.masterRootRouteName,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
//          navigatorObservers: [RoFNavigatorObserver()],
        ),
      ),
    ));
    if (RoFInfo.masterWidth < RoFInfo.windowWidth) {
      children.add(Container(
        width: 1,
        color: Color(0xFFDEE0E3),
      ));
    }

    return Row(children: children);
  }

  Widget _detail() {
    debugPrint('RoFInfo.masterWidth : ${RoFInfo.masterWidth}');
    debugPrint('GlobalKey<NavigatorState> : ${RoFInfo.kRoFSplitNavigatorStateDetail}');
    return Row(
      children: <Widget>[
        Container(
          width: RoFInfo.masterWidth,
          child: emptyMaster,
          color: Colors.white,
        ),
//        Container(
//          width: 1,
//          color: Color(0xFFDEE0E3),
//        ),
        Expanded(
            child: Container(
          color: Colors.red,
          child: CustomNavigator(
            navigatorKey: RoFInfo.kRoFSplitNavigatorStateDetail,
            initialRoute: widget.detailRootRouteName,
            onGenerateRoute: widget.onGenerateRoute,
            onUnknownRoute: widget.onUnknownRoute,
            navigatorObservers: navigatorObservers,
          ),
        )),
      ],
    );
  }
}

class ScreenEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
    );
  }
}

//class Split {
//  static const MethodChannel _channel =
//      const MethodChannel('split');
//
//  static Future<String> get platformVersion async {
//    final String version = await _channel.invokeMethod('getPlatformVersion');
//    return version;
//  }
//}
