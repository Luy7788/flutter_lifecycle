import 'package:flutter/material.dart';
import 'package:flutter_lifecycle/flutter_lifecycle.dart';

import 'item_lifecycle.dart';

class BasePageLifecycle extends StatefulWidget {
  final Widget child;
  ///页面创建
  final VoidCallback? onPageCreate;
  ///页面展示
  final VoidCallback? onPageShow;
  ///页面隐藏
  final VoidCallback? onPageHide;
  ///页面销毁
  final VoidCallback? onPageDispose;
  ///进入前台
  final VoidCallback? onForeground;
  ///失去活动
  final VoidCallback? onInactive;
  ///进入后台
  final VoidCallback? onBackground;
  ///是否是滚动视图的子组件
  final bool isScrollViewItem;

  const BasePageLifecycle({
    Key? key,
    required this.child,
    this.onPageCreate,
    this.onPageShow,
    this.onPageHide,
    this.onPageDispose,
    this.onBackground,
    this.onForeground,
    this.onInactive,
    this.isScrollViewItem = false,
  })  : super(key: key);

  @override
  State createState() {
    return _BasePageLifecycleState();
  }
}

class _BasePageLifecycleState extends LifecycleState<BasePageLifecycle> {

  /// 是否需要APP状态通知, true需要，false不需要
  /// background 、foreground 、inactive
  @override
  bool get needAppLifecycleEvent => widget.onBackground != null || widget.onForeground != null;

  /// 是否需要页面生命通知, true需要，false不需要
  /// create、show、hide、dispose
  @override
  bool get needPageLifecycleEvent => widget.onPageCreate != null ||
      widget.onPageShow != null ||
      widget.onPageHide != null ||
      widget.onPageDispose != null;

  @override
  void onPageCreate() {
    widget.onPageCreate?.call();
  }

  @override
  void onPageDispose() {
    widget.onPageDispose?.call();
  }

  @override
  void onPageShow() {
    if (widget.isScrollViewItem == true) return;
    widget.onPageShow?.call();
  }

  @override
  void onPageHide() {
    if (widget.isScrollViewItem == true) return;
    widget.onPageHide?.call();
  }

  @override
  void onBackground() {
    widget.onBackground?.call();
  }

  @override
  void onForeground() {
    widget.onForeground?.call();
  }

  @override
  void onInactive() {
    widget.onInactive?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isScrollViewItem == true) {
      return ItemLifecycle(
        key: Key("$hashCode"),
        stateCallback: (bool isShow, double visible) {
          if (visible == 1) {
            widget.onPageShow?.call();
          } else if(visible == 0) {
            widget.onPageHide?.call();
          }
        },
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }
}
