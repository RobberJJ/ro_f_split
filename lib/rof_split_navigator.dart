import 'package:RoFSplit/rof_router.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';

class RoFSplitNavigator extends StatefulWidget {
  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String initialRoute;

  /// navigator key
  final GlobalKey<NavigatorState> navigatorKey;

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

  RoFSplitNavigator({
    Key key,
    this.navigatorKey,
    this.initialRoute = '/',
    this.onGenerateRoute = RoFRouter.route,
    this.routes = const <String, WidgetBuilder>{},
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
  }) : super(key: key);
  @override
  _RoFSplitNavigatorState createState() => _RoFSplitNavigatorState();
}

class _RoFSplitNavigatorState extends State<RoFSplitNavigator> {
  @override
  Widget build(BuildContext context) {
    return CustomNavigator(
        navigatorKey: widget.navigatorKey,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
        onUnknownRoute: widget.onUnknownRoute,
        navigatorObservers: widget.navigatorObservers,
    );
  }
}
