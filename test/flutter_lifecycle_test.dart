// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_lifecycle/flutter_lifecycle.dart';
// import 'package:flutter_lifecycle/flutter_lifecycle_platform_interface.dart';
// import 'package:flutter_lifecycle/flutter_lifecycle_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockFlutterLifecyclePlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterLifecyclePlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final FlutterLifecyclePlatform initialPlatform = FlutterLifecyclePlatform.instance;
//
//   test('$MethodChannelFlutterLifecycle is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterLifecycle>());
//   });
//
//   test('getPlatformVersion', () async {
//     FlutterLifecycle flutterLifecyclePlugin = FlutterLifecycle();
//     MockFlutterLifecyclePlatform fakePlatform = MockFlutterLifecyclePlatform();
//     FlutterLifecyclePlatform.instance = fakePlatform;
//
//     expect(await flutterLifecyclePlugin.getPlatformVersion(), '42');
//   });
// }
