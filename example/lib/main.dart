import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_example/page_view.dart';
import 'home_page.dart';
import 'package:flutter_lifecycle/flutter_lifecycle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        platform: TargetPlatform.iOS,
      ),
      navigatorObservers: [defaultLifecycleObserver],
      routes: {
        'sub1': (_) => Sub1(),
        'nav2': (_) => const Nav2Home(),
        'pageView': (_) => const PageViewTest(),
      },
      home: Builder(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }
}
