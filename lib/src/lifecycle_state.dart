import 'package:flutter/material.dart';
import '../flutter_lifecycle.dart';
import 'lifecycle_implements.dart';
import 'lifecycle_mixin.dart';

///需要生命周期的继承[LifecycleState]，
///MaterialApp需要设置navigatorObservers:[defaultLifecycleObserver]
///可以接收的事件查看[LifecycleImplements]
abstract class LifecycleState<T extends StatefulWidget> extends State<T>
    with LifecycleMixin, LifecycleImplements {

  /// 是否需要APP状态通知, true需要，false不需要
  /// background 、foreground 、inactive
  bool get needAppLifecycleEvent => true;

  /// 是否需要页面生命通知, true需要，false不需要
  /// create、show、hide、dispose
  bool get needPageLifecycleEvent => true;

  // ///页面创建
  // @override
  // void onPageCreate();
  //
  // ///页面销毁
  // @override
  // void onPageDispose();
  //
  // ///页面隐藏
  // @override
  // void onPageHide();
  //
  // ///页面展示
  // @override
  // void onPageShow();
  //
  // ///进入后台
  // @override
  // void onBackground();
  //
  // @override
  // void onForeground();
  //
  // ///失去活动
  // @override
  // void onInactive();

  @override
  Widget build(BuildContext context) {
    // TODO: 需要自己实现
    throw UnimplementedError();
  }

  LifecycleObserver? _lifecycleObserver;
  ModalRoute? _route;

  @mustCallSuper
  @override
  void initState() {
    if (needPageLifecycleEvent) onPageCreate();
    super.initState();
    // debugPrint("initState this:$this");
  }

  @mustCallSuper
  @override
  void dispose() {
    if (needPageLifecycleEvent) onPageDispose();
    _lifecycleObserver?.unsubscribe(this);
    super.dispose();
    // debugPrint("dispose this:$this");
  }

  @mustCallSuper
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //是否需要生命周期回调
    if (needPageLifecycleEvent == false && needAppLifecycleEvent == false) return;
    // //是否是pageView内控件
    // if (isPageViewItem == true) return;

    _route = ModalRoute.of(context);
    // debugPrint("didChangeDependencies route.Name: ${_route?.settings.name}, this:$this");
    // 如果当前route正在popping，避免重复订阅。
    if (_route == null || !(_route?.isActive ?? false)) return;
    try {
      _lifecycleObserver = LifecycleObserver.internalGet(context);
      //添加订阅
      _lifecycleObserver?.subscribe(this, _route!);
    } catch (e) {
      debugPrint('didChangeDependencies LifecycleObserver.internalGet : $e');
    }
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    // debugPrint("onLifecycleEvent $event，${_route?.settings.name}, this:$this");
    switch (event) {
      case LifecycleEvent.pageShow:
        if (needPageLifecycleEvent) onPageShow();
        break;
      case LifecycleEvent.pageHide:
        if (needPageLifecycleEvent) onPageHide();
        break;
      case LifecycleEvent.appForeground:
        if (needAppLifecycleEvent) onForeground();
        break;
      case LifecycleEvent.appInactive:
        if (needAppLifecycleEvent) onInactive();
        break;
      case LifecycleEvent.appBackground:
        if (needAppLifecycleEvent) onBackground();
        break;
    }
  }
}
