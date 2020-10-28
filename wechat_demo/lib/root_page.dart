import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/chat_page.dart';
import 'package:wechat_demo/pages/discover/discover_page.dart';
import 'package:wechat_demo/pages/friends/friends_page.dart';
import 'package:wechat_demo/pages/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentindex = 0;
  List<Widget> _pages = [ChatPage(), FriendsPage(), DiscoverPage(), MinePage()];
  final PageController _pageController = PageController(initialPage: 3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
//        onPageChanged: (int n) {
//          _currentindex = n;
//          setState(() {});
//        },
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
          _pageController.jumpToPage(index);
        },
        selectedFontSize: 12.0,
//        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentindex,
        fixedColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_chat.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_chat_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('微信'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_friends.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_friends_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('通讯录'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_discover.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_discover_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_mine.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_mine_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('我'),
          ),
        ],
      ),
    );
  }
}
