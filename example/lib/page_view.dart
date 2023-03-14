import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewTest extends StatefulWidget {
  const PageViewTest({Key? key}) : super(key: key);

  @override
  _PageViewTestState createState() {
    return _PageViewTestState();
  }
}

class _PageViewTestState extends State<PageViewTest> {
  int _currentPageIndex = 0;
  var pageList = ['首页', '推荐', '我的'];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemCount: pageList.length,
        itemBuilder: (context, index) {
          return _buildPageViewItem(
            pageList[index % (pageList.length)],
          );
        },
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  _buildPageViewItem(String txt) {
    return PageViewItem(
      color: Colors.deepPurpleAccent,
      txt: txt,
    );
  }

  bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentPageIndex,
      onTap: (index) {
        setState(() {
          _currentPageIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(label: pageList[0], icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: pageList[1], icon: Icon(Icons.book)),
        BottomNavigationBarItem(
            label: pageList[2], icon: Icon(Icons.perm_identity)),
      ],
    );
  }
}

class PageViewItem extends StatefulWidget {
  final String txt;
  final Color color;

  const PageViewItem({
    Key? key,
    required this.txt,
    required this.color,
  }) : super(key: key);

  @override
  _PageViewItemState createState() {
    return _PageViewItemState();
  }
}

class _PageViewItemState extends State<PageViewItem> with AutomaticKeepAliveClientMixin  {
  @override
  void initState() {
    super.initState();
    debugPrint("initState: ${widget.txt}");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose: ${widget.txt}");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    debugPrint("didChangeDependencies : ${widget.txt}");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: widget.color,
      alignment: Alignment.center,
      child: Text(
        widget.txt,
        style: const TextStyle(color: Colors.white, fontSize: 28),
      ),
    );
  }
}
