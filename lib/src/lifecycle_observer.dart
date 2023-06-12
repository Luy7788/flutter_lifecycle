import 'package:flutter/material.dart';
import 'lifecycle_mixin.dart';
import 'route_entry.dart';

final LifecycleObserver defaultLifecycleObserver = LifecycleObserver(isDebug: false);
class LifecycleObserver extends NavigatorObserver with WidgetsBindingObserver {
  static final List<LifecycleObserver> _cache = [];

  ///当前路由
  final List<RouteEntry> _history = [];

  bool? isDebugPrint;

  LifecycleObserver({bool isDebug = false}) {
    isDebugPrint = isDebug;
    _cache.add(this);
    WidgetsBinding.instance.addObserver(this);
  }

  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cache.remove(this);
  }

  ///获取当前的路由栈
  List<RouteEntry> getHistory() {
    return _history;
  }

  // @override
  // Future<bool> didPushRoute(String route) {
  //   debugPrint("LifecycleObserver didPushRoute:$route");
  //   return super.didPushRoute(route);
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _print("LifecycleObserver:Binding app进入前台");
      _sendAppLifecycleEvent(LifecycleEvent.appForeground);
    } else if (state == AppLifecycleState.inactive) {
      _print("LifecycleObserver:Binding app在前台但不响应事件");
      _sendAppLifecycleEvent(LifecycleEvent.appInactive);
    } else if (state == AppLifecycleState.paused) {
      _print("LifecycleObserver:Binding app进入后台");
      _sendAppLifecycleEvent(LifecycleEvent.appBackground);
    } else if (state == AppLifecycleState.detached) {
      _print("LifecycleObserver:Binding 没有宿主视图但是flutter引擎仍然有效");
    }
  }

  _print(String? message, { int? wrapWidth }) {
    if (isDebugPrint == true) {
      debugPrint(message, wrapWidth:wrapWidth);
    }
  }

  ///通知APP生命周期事件
  void _sendAppLifecycleEvent(LifecycleEvent event) {
    for (var routeEntry in _history) {
      routeEntry.sendEventsToSubscribers([event]);
    }
  }

  /// The [Navigator] pushed `route`.
  ///
  /// The route immediately below that one, and thus the previously active
  /// route, is `previousRoute`.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _print("LifecycleObserver didPush: route:${routePrint(route)}, previousRoute:${routePrint(previousRoute)}");
    var routeEntry = RouteEntry(route);
    _history.add(routeEntry);
    route.didPush().whenComplete(() {
      //发生生命周期通知
      routeEntry.sendEventsToSubscribers([LifecycleEvent.pageShow]);
      if (previousRoute != null) {
        var previousRouteEntry = getRouteEntry(previousRoute);
        previousRouteEntry?.sendEventsToSubscribers([LifecycleEvent.pageHide]);
      }
    });
  }

  /// The [Navigator] popped `route`.
  ///
  /// The route immediately below that one, and thus the newly active
  /// route, is `previousRoute`.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _print("LifecycleObserver didPop: route:${routePrint(route)}, previousRoute:${routePrint(previousRoute)}");
    route.popped.whenComplete(() {
      var routeEntry = getRouteEntry(route);
      routeEntry?.sendEventsToSubscribers([LifecycleEvent.pageHide]);
      _history.remove(routeEntry);
    });
    if (previousRoute != null) {
      var previousRouteEntry = getRouteEntry(previousRoute);
      previousRouteEntry?.sendEventsToSubscribers([LifecycleEvent.pageShow]);
    }
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
    _print("LifecycleObserver didRemove: route:${routePrint(route)}, previousRoute:${routePrint(previousRoute)}");
    //Whether this route is the top-most route on the navigator.
    if (previousRoute?.isCurrent ?? false) {
      var previousRouteEntry = getRouteEntry(previousRoute);
      previousRouteEntry?.sendEventsToSubscribers([LifecycleEvent.pageShow]);
    }
  }

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _print("LifecycleObserver didReplace: route:${routePrint(newRoute)}, previousRoute:${routePrint(oldRoute)}");
    if (newRoute != null) {
      var routeEntry = RouteEntry(newRoute);
      _history.add(routeEntry);
      newRoute.didPush().whenComplete(() {
        //发生生命周期通知
        routeEntry.sendEventsToSubscribers([LifecycleEvent.pageShow]);
      });
    }
    if (oldRoute != null) {
      var previousRouteEntry = getRouteEntry(oldRoute);
      previousRouteEntry?.sendEventsToSubscribers([LifecycleEvent.pageHide]);
    }
  }

  /// The [Navigator]'s routes are being moved by a user gesture.
  ///
  /// For example, this is called when an iOS back gesture starts, and is used
  /// to disabled hero animations during such interactions.
  /// iOS侧边手势滑动触发回调 手势开始时回调
  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didStartUserGesture(route, previousRoute);
    _print("LifecycleObserver didStartUserGesture: route:${routePrint(route)}, previousRoute:${routePrint(previousRoute)}");
  }

  /// User gesture is no longer controlling the [Navigator].
  ///
  /// Paired with an earlier call to [didStartUserGesture].
  /// iOS侧边手势滑动触发停止时回调 不管页面是否退出了都会调用
  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _print("LifecycleObserver didStopUserGesture");
  }

  /// [lifecycleAware] subscribes events.
  ///
  /// [route]有变化时，通知[lifecycleAware]。
  void subscribe(
    LifecycleMixin lifecycleAware,
    Route route,
  ) {
    RouteEntry? entry = getRouteEntry(route);
    if (entry != null && entry.lifecycleSubscribers.add(lifecycleAware)) {
      _print('LifecycleObserver($hashCode)#subscribe(${lifecycleAware.toString()})');
      // entry.sendEvents(lifecycleAware, [LifecycleEvent.pageShow]);
    }
  }

  /// [lifecycleAware] unsubscribes events.
  ///
  /// [lifecycleAware]取消订阅事件。
  void unsubscribe(LifecycleMixin lifecycleAware) {
    _print('LifecycleObserver($hashCode)#unsubscribe(${lifecycleAware.toString()})');
    for (final RouteEntry entry in _history) {
      entry.lifecycleSubscribers.remove(lifecycleAware);
    }
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

  String routePrint(Route<dynamic>? route, {bool argument = false}) {
    if (route?.settings.name == null && route?.hashCode == null) {
      return "空";
    }
    if (argument == true) {
      return "[name->${route?.settings.name} code->${route?.hashCode} arguments->${route?.settings.arguments}]";
    }
    return "[name->${route?.settings.name} code->${route?.hashCode}]";
  }

  ///获取对应的LifecycleObserver，防止有多个
  @protected
  factory LifecycleObserver.internalGet(BuildContext context) {
    NavigatorState navigator = Navigator.of(context);
    for (int i = _cache.length - 1; i >= 0; i--) {
      LifecycleObserver observer = _cache[i];
      if (observer.navigator == navigator) {
        return observer;
      }
    }
    throw Exception(
        'Can not get associated LifecycleObserver, did you forget to register it in MaterialApp or Navigator?');
  }
}
