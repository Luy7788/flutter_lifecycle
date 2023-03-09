import 'package:flutter/cupertino.dart';

enum LifecycleEvent {
  pageShow,
  pageHide,
  appBackground,
  appForeground,
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

  /// Used for an indexed child, such as an item of [ListView]/[GridView].
  int? get itemIndex => null;
}
