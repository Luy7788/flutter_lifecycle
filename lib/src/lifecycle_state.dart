import 'package:flutter/material.dart';
import '../flutter_lifecycle.dart';

class LifecycleState <T extends StatefulWidget> extends State<T> with LifecycleMixin, LifecycleImplements{
  LifecycleObserver? _lifecycleObserver;
  ModalRoute? _route;

  @override
  Widget build(BuildContext context) {
    // TODO: 需要自己实现
    throw UnimplementedError();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // debugPrint("initState this:$this");
  }

  @override
  void dispose() {
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
    // debugPrint("onLifecycleEvent $event，${_route?.settings.name}, this:$this");
    switch (event) {
      case LifecycleEvent.pageShow:
        onPageShow();
        break;
      case LifecycleEvent.pageHide:
        onPageHide();
        break;
      case LifecycleEvent.appForeground:
        onForeground();
        break;
      case LifecycleEvent.appInactive:
        break;
      case LifecycleEvent.appBackground:
        onBackground();
        break;
    }
  }

}
