import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  MethodChannel _methodChannel = MethodChannel('mine_page');
  File _avatarFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel.setMethodCallHandler((call) {
      if (call.method == 'imgPath') {
        String imgPath = call.arguments.toString().substring(7);
        print('imgpath=${imgPath}');
        setState(() {
          _avatarFile = File(imgPath);
        });
      }
      return;
    });
  }

  Widget headerWidget() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 5,
          top: 100,
          bottom: 20,
        ),
        padding: EdgeInsets.all(5),
        child: Container(
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('切换头像');
                  _methodChannel
                      .invokeMapMethod('picture', ['a', 'b', 'c']).then(print);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: _avatarFile == null
                            ? AssetImage('images/Hank.png')
                            : FileImage(_avatarFile), //
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
//                width: MediaQuery.of(context).size.width - 110,
//                color: Colors.red,
                margin: EdgeInsets.only(
                  left: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
//                      color: Colors.blue,
                      child: Text(
                        'Hank',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
//                      margin: EdgeInsets.only(left: 0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '微信号:11111',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Image(
                            image: AssetImage('images/icon_right.png'),
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(220, 220, 220, 1),
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    headerWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信 支付.png',
                      title: '支付',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信收藏.png',
                      title: '收藏',
                    ),
                    DiscoverCell(
                      imageName: 'images/微信相册.png',
                      title: '相册',
                    ),
                    DiscoverCell(
                      imageName: 'images/微信卡包.png',
                      title: '卡包',
                    ),
                    DiscoverCell(
                      imageName: 'images/微信表情.png',
                      title: '表情',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信设置.png',
                      title: '设置',
                    ),
                  ],
                )),
          ),
          Container(
            height: 25,
            margin: EdgeInsets.only(
              top: 34,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(image: AssetImage('images/相机.png')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
