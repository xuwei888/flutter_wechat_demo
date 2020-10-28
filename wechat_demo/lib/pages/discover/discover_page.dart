import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_cell.dart';

class DiscoverPage extends StatefulWidget {
  Color _themeColor = Color.fromRGBO(220, 220, 220, 1.0);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget._themeColor,
        centerTitle: true,
        title: Text(
          '发现',
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: widget._themeColor,
        child: ListView(
          children: <Widget>[
            DiscoverCell(
              title: '朋友圈',
              imageName: 'images/朋友圈.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: '扫一扫',
              imageName: 'images/扫一扫.png',
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                ),
              ],
            ),
            DiscoverCell(
              title: '摇一摇',
              imageName: 'images/摇一摇.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/看一看icon.png',
              title: '看一看',
            ),
            Row(
              children: <Widget>[
                Container(width: 50, height: 0.5, color: Colors.white),
                Container(height: 0.5, color: Colors.grey)
              ],
            ),
            DiscoverCell(
              imageName: 'images/搜一搜 2.png',
              title: '搜一搜',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/附近的人icon.png',
              title: '附近的人',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/购物.png',
              title: '购物',
              subTitle: '618限时特价',
              subImageName: 'images/badge.png',
            ),
            Row(
              children: <Widget>[
                Container(width: 50, height: 0.5, color: Colors.white),
                Container(height: 0.5, color: Colors.grey)
              ],
            ),
            DiscoverCell(
              imageName: 'images/游戏.png',
              title: '游戏',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '小程序',
            ),
          ],
        ),
      ),
    );
  }
}
