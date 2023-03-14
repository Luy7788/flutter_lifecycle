import 'package:flutter/material.dart';
import 'package:flutter_lifecycle/flutter_lifecycle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends LifecycleState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: const Text('Open Sub1Page'),
              onPressed: () {
                Navigator.of(context).pushNamed('sub1');
              },
            ),
            ElevatedButton(
              child: const Text('Open Nav2.0'),
              onPressed: () {
                Navigator.of(context).pushNamed('nav2');
                // Navigator.of(context).replace(oldRoute: oldRoute, newRoute: newRoute)
              },
            ),
            ElevatedButton(
              child: const Text('Open dialog.0'),
              onPressed: () {
                showDialog(
                  context: context,
                  routeSettings: const RouteSettings(name: 'dialog'),
                  builder: (context) {
                    return Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        color: Colors.pink.shade100,
                        child: Nav2Page2(
                          onHidePage2: () {
                            Navigator.of(context, rootNavigator: true)
                                .maybePop();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text('Open PageView page'),
              onPressed: () {
                Navigator.of(context).pushNamed('pageView');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Nav2Home extends StatefulWidget {
  const Nav2Home({Key? key}) : super(key: key);

  @override
  _Nav2HomeState createState() {
    return _Nav2HomeState();
  }
}

class _Nav2HomeState extends LifecycleState<Nav2Home> {
  bool _showPage1 = true;
  bool _showPage2 = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    debugPrint("didChangeDependencies _Nav2HomeState");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Nav2Page2(
      onHidePage2: () {
        setState(() {
          _showPage2 = false;
        });
      },
    );
  }
}

class Nav2Page2 extends StatefulWidget {
  final VoidCallback? onHidePage2;

  const Nav2Page2({Key? key, required this.onHidePage2}) : super(key: key);

  @override
  _Nav2Page2State createState() {
    return _Nav2Page2State();
  }
}

class _Nav2Page2State extends LifecycleState<Nav2Page2> {
  @override
  void initState() {
    super.initState();
    // log.add('Nav2Page2($hashCode)#initState()');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print('Nav2Page2($hashCode)#didChangeDependencies() route(${ModalRoute.of(context).hashCode})');
  }

  @override
  void dispose() {
    // log.add('Nav2Page2($hashCode)#dispose()');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nav2'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).maybePop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  // routeSettings: const RouteSettings(name: 'dialog'),
                  builder: (context) {
                    return AlertDialog(
                      content: const Text(
                        'This is a dialog.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Dismiss'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Open nav2'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('nav2');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('show Alert Dialog'),
            ),
            TextButton(
              onPressed: widget.onHidePage2,
              child: const Text('Hide Page2'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('pop pop'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() {
    return _ListPageState();
  }
}

class _ListPageState extends LifecycleState<ListPage> {
  List _data = [];

  @override
  void initState() {
    super.initState();
    _data = List<String>.generate(20, (index) => 'Item $index');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ListPage',
        ),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          // return ListItem(index: index);
          return ListTile(
            title: Text(
              _data[index],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_data.isNotEmpty) {
            setState(() {
              _data.removeLast();
            });
          }
        },
        label: const Text('Remove last'),
        icon: const Icon(Icons.remove),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}

class Sub1 extends StatefulWidget {
  String? title;

  Sub1({Key? key, this.title}) : super(key: key);

  @override
  _Sub1State createState() {
    return _Sub1State();
  }
}

class _Sub1State extends LifecycleState<Sub1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Sub1"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('nav2');
              },
              child: const Text("replace"),
            ),
            TextButton(
              onPressed: () {
                var _route = ModalRoute.of(context);
                Navigator.of(context).pushNamed('nav2');
                Future.delayed(Duration(milliseconds: 300)).then((value) => Navigator.of(context).removeRoute(_route!));
              },
              child: const Text('pushAndRemove'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed('nav2');
                // Navigator.of(context).pushNamed('sub1');
              },
              child: const Text('push'),
            ),
          ],
        ),
      ),
    );
  }
}
