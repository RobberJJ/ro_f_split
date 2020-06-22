import 'dart:ui';
import 'package:RoFSplit/rof_info.dart';
import 'package:RoFSplit/rof_split_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoFSplit extends StatefulWidget {

  final RoFSplitNavigator master;

  final RoFSplitNavigator detail;

  final double masterWidth;

  const RoFSplit({
    Key key,
    this.master,
    this.detail,
    this.masterWidth,
  }) : super(key: key);

  @override
  _RoFSplitState createState() => _RoFSplitState();
}

class _RoFSplitState extends State<RoFSplit> with WidgetsBindingObserver {
  final ScreenEmptyWidget emptyMaster = ScreenEmptyWidget();

  bool isSplitLast;

//  RoFNavigatorObserver _navigatorObserver;
  List<NavigatorObserver> navigatorObservers = <NavigatorObserver>[];

  @override
  void initState() {
//    WidgetsBinding.instance.addObserver(this);
//    navigatorObservers.addAll(widget.navigatorObservers);
//    _navigatorObserver = RoFNavigatorObserver(onRefresh: _onRefresh);
//    navigatorObservers.add(_navigatorObserver);
    super.initState();

    debugPrint('onRefresh init');
  }

  @override
  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

//  @override
//  void didChangeMetrics() {
//    RoFInfo.devicePixelRatio = window.devicePixelRatio;
//    RoFInfo.windowWidth = window.physicalSize.width / RoFInfo.devicePixelRatio;
//    RoFInfo.windowHeight =
//        window.physicalSize.height / RoFInfo.devicePixelRatio;
//    debugPrint(
//        'window width: ${RoFInfo.windowWidth}  height: ${RoFInfo.windowHeight} devicePixelRatio : ${window.devicePixelRatio}');
//    RoFDevice().deviceInfo.then((value) {
//      if (value is RoFDeviceInfoIos) {
//        RoFInfo.screenWidth = value.screenWidth;
//        RoFInfo.screenHeight = value.screenHeight;
//        RoFInfo.isIpad = value.deviceType == 'ipad';
//        debugPrint(
//            'device info: device type ${value.deviceType} SW ${value.screenWidth} SH ${value.screenHeight}');
//        debugPrint(
//            'RoFInfo.isSplit || RoFInfo.isRootForDetail ${RoFInfo.isSplit} ${RoFInfo.isRootForDetail}');
//        if (isSplitLast != RoFInfo.isSplit) {
//          this.setState(() {
//            isSplitLast = RoFInfo.isSplit;
//          });
//        }
//      } else {
//        RoFInfo.isIpad = false;
//      }
//    });
//
//    super.didChangeMetrics();
//  }

//  void _onRefresh() {
//    debugPrint('onRefresh');
//    this.setState(() {});
//  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (widget.detail != null) children.add(_detail());
    if (widget.master != null) children.add(_master());
    debugPrint('children $children');
    return Stack(
      children: children,
    );
  }

  Widget _master() {
    List<Widget> children = <Widget>[];
    debugPrint("111111111111 ${RoFInfo.masterWidth} ${RoFInfo.screenWidth}");
    children.add(Container(
      width: widget.masterWidth,
      child: widget.master,
    ));
    children.add(Container(
      width: 1,
      color: Color(0xFFDEE0E3),
    ));
//    if (RoFInfo.masterWidth < RoFInfo.windowWidth) {
//
//    }
    return Row(children: children);
  }

  Widget _detail() {
    return Row(
      children: <Widget>[
        Container(
          width: widget.masterWidth??0,
          child: emptyMaster,
          color: Colors.white,
        ),
        Expanded(
            child: Container(
          child: widget.detail,
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
