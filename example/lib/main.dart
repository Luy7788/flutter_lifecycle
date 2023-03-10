import 'package:flutter/material.dart';
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
        'list': (_) => const ListPage(),
      },

      home: Builder(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }
}
