///回调的几个方法
abstract class LifecycleImplements {

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

  ///进入后台
  void onBackground();

  ///失去活动
  void onInactive();
}