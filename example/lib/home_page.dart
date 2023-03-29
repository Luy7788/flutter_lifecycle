import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle/flutter_lifecycle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
    return BasePageLifecycle(
      onPageShow: (){
        debugPrint('Home');
      },
      child: Scaffold(
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
              Expanded(
                child: PageView.builder(itemBuilder: (BuildContext context, int index) {
                  // double widthFactor = 1.0 - (index * 0.2);
                  return Container(
                    width: MediaQuery.of(context).size.width - 50 * index,
                    color: Colors.accents[index],
                    child: Text('index $index'),
                  );
                },
                  itemCount: 4,
                  controller: PageController(initialPage: 0, viewportFraction: 0.8),
                  // padEnds: false,
                  // pageSnapping: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Nav2 extends StatefulWidget {
  const Nav2({Key? key}) : super(key: key);

  @override
  State createState() {
    return _Nav2State();
  }
}

class _Nav2State extends State<Nav2> {
  // bool _showPage1 = true;
  // bool _showPage2 = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // debugPrint("didChangeDependencies _Nav2HomeState");
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
    return BasePageLifecycle(
      onPageShow: (){
        debugPrint('Nav2');
      },
      child: Nav2Page2(
        onHidePage2: () { },
      ),
    );
  }
}

class Nav2Page2 extends StatefulWidget {
  final VoidCallback? onHidePage2;

  const Nav2Page2({Key? key, required this.onHidePage2}) : super(key: key);

  @override
  State createState() {
    return _Nav2Page2State();
  }
}

class _Nav2Page2State extends State<Nav2Page2> {
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
    return  BasePageLifecycle(
      onPageShow: (){
        debugPrint('Nav2Page2');
      },
      child: Scaffold(
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
                  // Navigator.of(context).pop();
                },
                child: const Text('pop '), //pop pop
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Sub1 extends StatefulWidget {
  String? title;

  Sub1({Key? key, this.title}) : super(key: key);

  @override
  State createState() {
    return _Sub1State();
  }
}

class _Sub1State extends State<Sub1> {
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
    return  BasePageLifecycle(
      onPageShow: (){
        debugPrint('Sub1');
      },
      child: Scaffold(
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
                  var route = ModalRoute.of(context);
                  Navigator.of(context).pushNamed('nav2');
                  Future.delayed(const Duration(milliseconds: 300)).then((value) => Navigator.of(context).removeRoute(route!));
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
      ),
    );
  }
}
