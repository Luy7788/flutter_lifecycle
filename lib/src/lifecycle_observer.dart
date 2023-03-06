import 'package:flutter/material.dart';
import 'route_entry.dart';

class LifecycleObserver extends NavigatorObserver with WidgetsBindingObserver {

  static final List<LifecycleObserver> _cache = [];

  ///当前路由
  final List<RouteEntry> _history = [];

  LifecycleObserver() {
    _cache.add(this);
    WidgetsBinding.instance.addObserver(this);
  }

  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cache.remove(this);
  }

  @override
  Future<bool> didPushRoute(String route) {
    debugPrint("LifecycleObserver didPushRoute:$route");
    return super.didPushRoute(route);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      debugPrint("LifecycleObserver:Binding app进入前台");
    } else if (state == AppLifecycleState.inactive) {
      debugPrint("LifecycleObserver:Binding app在前台但不响应事件");
    } else if (state == AppLifecycleState.paused) {
      debugPrint("LifecycleObserver:Binding app进入后台");
    } else if (state == AppLifecycleState.detached) {
      debugPrint("LifecycleObserver:Binding 没有宿主视图但是flutter引擎仍然有效");
    }
  }

  /// The [Navigator] pushed `route`.
  ///
  /// The route immediately below that one, and thus the previously active
  /// route, is `previousRoute`.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint("LifecycleObserver didPush: route:$route, previousRoute:$previousRoute");
    _history.add(RouteEntry(route));
  }

  /// The [Navigator] popped `route`.
  ///
  /// The route immediately below that one, and thus the newly active
  /// route, is `previousRoute`.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint("LifecycleObserver didPop: route:$route, previousRoute:$previousRoute");
  }

  /// The [Navigator] removed `route`.
  ///
  /// If only one route is being removed, then the route immediately below
  /// that one, if any, is `previousRoute`.
  ///
  /// If multiple routes are being removed, then the route below the
  /// bottommost route being removed, if any, is `previousRoute`, and this
  /// method will be called once for each removed route, from the topmost route
  /// to the bottommost route.
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint("LifecycleObserver didRemove: route:$route, previousRoute:$previousRoute");
  }

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  @override
  void didReplace({ Route<dynamic>? newRoute, Route<dynamic>? oldRoute }) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint("LifecycleObserver didReplace: route:$newRoute, previousRoute:$oldRoute");
  }

  /// The [Navigator]'s routes are being moved by a user gesture.
  ///
  /// For example, this is called when an iOS back gesture starts, and is used
  /// to disabled hero animations during such interactions.
  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    debugPrint("LifecycleObserver didStartUserGesture: route:$route, previousRoute:$previousRoute");
  }

  /// User gesture is no longer controlling the [Navigator].
  ///
  /// Paired with an earlier call to [didStartUserGesture].
  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    debugPrint("LifecycleObserver didStopUserGesture");
  }

  ///获取对应RouteEntry
  RouteEntry? getRouteEntry(Route<dynamic>? route) {
    if (route != null) {
      for (var item in _history) {
        if (item.route == route) {
          return item;
        }
      }
    }
    return null;
  }

}