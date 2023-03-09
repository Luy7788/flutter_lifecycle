import 'package:flutter/material.dart';
import 'package:flutter_lifecycle/src/lifecycle_mixin.dart';
import '../flutter_lifecycle.dart';

class RouteEntry {
  RouteEntry(this.route);

  final Route<dynamic> route;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteEntry &&
          runtimeType == other.runtimeType &&
          route.hashCode == other.route.hashCode;

  @override
  int get hashCode => route.hashCode;
  
  final Set<LifecycleMixin> lifecycleSubscribers = {};

  ///通知监听的页面事件
  void sendEventsToSubscribers(List<LifecycleEvent> events) {
    for (LifecycleMixin lifecycleAware in lifecycleSubscribers) {
      _sendEvents(lifecycleAware, events);
    }
  }

  void _sendEvents(LifecycleMixin lifecycleAware, List<LifecycleEvent> events) {
    lifecycleAware.handleLifecycleEvents(events);
  }

}
