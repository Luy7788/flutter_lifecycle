# flutter_lifecycle

flutter页面生命周期插件；可根据这个插件设计项目基类widget,底下demo

## 接入步骤：
* 1. 引入

```
import 'package:flutter_lifecycle/flutter_lifecycle.dart';
```

* 2. 设置MaterialApp->navigatorObservers: [defaultLifecycleObserver]

```
MaterialApp(
      navigatorObservers: [defaultLifecycleObserver],
      routes: {
        'sub1': (_) => Sub1(),
        'nav2': (_) => const Nav2Home(),
      },
      home: HomePage(),
    );
```

* 3. 需要获取页面生命周期的StatefulWidget的state继承 LifecycleState，提供以下方法：

```
  ///页面创建
  void onPageCreate();
  ///页面展示
  void onPageShow();
  ///页面隐藏
  void onPageHide();
  ///页面销毁
  void onPageDispose();
  ///回调前台
  void onForeground();
  ///失去活动
  void onInactive();
  ///进入后台
  void onBackground();
```

* ps. 可以根据场景设置是否需要回调事件

```
  /// 是否需要APP状态通知, true需要，false不需要
  /// background 、foreground 、inactive
  bool get needAppLifecycleEvent => true;

  /// 是否需要页面生命通知, true需要，false不需要
  /// create、show、hide、dispose
  bool get needPageLifecycleEvent => true;
```

##  以下demo:

```

///基础容器
class BaseContainer extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPageCreate;
  final VoidCallback? onPageShow;
  final VoidCallback? onPageHide;
  final VoidCallback? onPageDispose;
  final VoidCallback? onBackground;
  final VoidCallback? onForeground;
  final VoidCallback? onInactive;

  const BaseContainer({
    Key? key,
    this.child,
    this.onPageCreate,
    this.onPageShow,
    this.onPageHide,
    this.onPageDispose,
    this.onBackground,
    this.onForeground,
    this.onInactive,
  })  : super(key: key);

  @override
  State createState() {
    return _BaseContainerState();
  }
}

class _BaseContainerState extends LifecycleState<BaseContainer> {
    
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
    super.onPageCreate();
    widget.onPageCreate?.call();
  }

  @override
  void onPageDispose() {
    super.onPageDispose();
    widget.onPageDispose?.call();
  }

  @override
  void onPageShow() {
    super.onPageShow();
    widget.onPageShow?.call();
  }

  @override
  void onPageHide() {
    super.onPageHide();
    widget.onPageHide?.call();
  }

  @override
  void onBackground() {
    super.onBackground();
    widget.onBackground?.call();
  }

  @override
  void onForeground() {
    super.onForeground();
    widget.onForeground?.call();
  }

  @override
  void onInactive() {
    super.onInactive();
    widget.onInactive?.call();
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
           color: widget.backgroundColor,
           child: widget.child,
    );
  }
}

```
