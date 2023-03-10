import 'package:flutter/cupertino.dart';

enum LifecycleEvent {
  //页面的
  pageShow,
  pageHide,
  //应用的
  appForeground,
  appInactive,
  appBackground,
}

///混入
mixin LifecycleMixin {

  LifecycleEvent? _currentLifecycleState;

  /// Current lifecycle.
  LifecycleEvent? get currentLifecycleState => _currentLifecycleState;

  @mustCallSuper
  void handleLifecycleEvents(List<LifecycleEvent> events) {
    if (_currentLifecycleState == events.last) {
      return;
    }
    List<LifecycleEvent> fixedEvents = events;
    // 分发 events
    for (LifecycleEvent event in fixedEvents) {
      if (event != _currentLifecycleState) {
        _currentLifecycleState = event;
        onLifecycleEvent(event);
      }
    }
  }

  /// [LifecycleEvent] callback.
  void onLifecycleEvent(LifecycleEvent event);
}
