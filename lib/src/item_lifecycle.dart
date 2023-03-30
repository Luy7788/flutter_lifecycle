import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../flutter_lifecycle.dart';

class ItemLifecycle extends StatefulWidget {
  final Widget child;
  final VisibleCallback stateCallback;

  const ItemLifecycle({
    required Key? key,
    required this.child,
    required this.stateCallback,
  }) : super(key: key);

  @override
  State createState() {
    return _ItemLifecycleState();
  }
}

class _ItemLifecycleState extends LifecycleState<ItemLifecycle> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onBackground() {
    // TODO: implement onBackground
  }

  @override
  void onPageCreate() {
    // TODO: implement onPageCreate
  }

  @override
  void onPageDispose() {
    // TODO: implement onPageDispose
  }

  @override
  void onPageHide() {
    // TODO: implement onPageHide
  }

  @override
  void onPageShow() {
    // TODO: implement onPageShow
  }

  @override
  void onForeground() {
    // TODO: implement onForeground
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("$hashCode"),
      onVisibilityChanged: (visibilityInfo) {
        widget.stateCallback(visibilityInfo.visibleFraction>0, visibilityInfo.visibleFraction);
      },
      child: widget.child,
    );
  }

}

/// VisibleCallback，返回当前视图是否可见
/// show, true可见，false不可见
/// visibleValue可见程度 ==1 完全展示
typedef VisibleCallback = Function(bool show, double visibleValue);