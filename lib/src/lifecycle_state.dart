import 'package:flutter/material.dart';
import '../flutter_lifecycle.dart';
import 'lifecycle_implements.dart';
import 'lifecycle_mixin.dart';

///需要生命周期的继承[LifecycleState]，
///MaterialApp需要设置navigatorObservers:[defaultLifecycleObserver]
///可以接收的事件查看[LifecycleImplements]
abstract class LifecycleState<T extends StatefulWidget> extends State<T>
    with LifecycleMixin, LifecycleImplements {

  /// 是否需要APP状态通知
  bool get needAppLifecycleEvent => true;

  @override
  void onBackground() {
    // TODO: implement onBackground
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
  Widget build(BuildContext context) {
    // TODO: 需要自己实现
    throw UnimplementedError();
  }

  LifecycleObserver? _lifecycleObserver;
  ModalRoute? _route;

  @override
  void initState() {
    // TODO: implement initState
    onPageCreate();
    super.initState();
    // debugPrint("initState this:$this");
  }

  @override
  void dispose() {
    onPageDispose();
    _lifecycleObserver?.unsubscribe(this);
    super.dispose();
    // debugPrint("dispose this:$this");
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context);
    // debugPrint("didChangeDependencies route.Name: ${_route?.settings.name}, this:$this");
    // 如果当前route正在popping，避免重复订阅。
    if (_route == null || !(_route?.isActive ?? false)) return;
    _lifecycleObserver = LifecycleObserver.internalGet(context);
    //添加订阅
    _lifecycleObserver?.subscribe(this, _route!);
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    debugPrint("onLifecycleEvent $event，${_route?.settings.name}, this:$this");
    switch (event) {
      case LifecycleEvent.pageShow:
        onPageShow();
        break;
      case LifecycleEvent.pageHide:
        onPageHide();
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
