import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/pages/discover/discover_child_page.dart';
import 'package:wechat_demo/pages/friends/friends_data.dart';
import 'package:wechat_demo/pages/friends/index_bar.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };

  ScrollController _scrollController;
  final List<Friends> _listDatas = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listDatas.addAll(datas);

    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });
    _scrollController = ScrollController();
    var _groupOffset = 54.5 * 4;
    for (int index = 0; index < _listDatas.length; index++) {
      bool _showLetter = index == 0 ||
          _listDatas[index].indexLetter != _listDatas[index - 1].indexLetter;
      if (_showLetter) {
        _groupOffsetMap.addAll({_listDatas[index].indexLetter: _groupOffset});
        _groupOffset += 84.5;
      } else {
        _groupOffset += 54.5;
      }
    }
  }

  final List<Friends> _headerData = [
    Friends(
      imageUrl: 'images/新的朋友.png',
      name: '新的朋友',
    ),
    Friends(
      imageUrl: 'images/群聊.png',
      name: '群聊',
    ),
    Friends(
      imageUrl: 'images/标签.png',
      name: '标签',
    ),
    Friends(
      imageUrl: 'images/公众号.png',
      name: '公众号',
    ),
  ];

  Widget _itemForRow(BuildContext context, int index) {
    if (index < _headerData.length) {
      return _FriendCell(
        imageAssets: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    } else {
      bool _showLetter = index == 4 ||
          _listDatas[index - 4].indexLetter !=
              _listDatas[index - 5].indexLetter;
      return _FriendCell(
        imageUrl: _listDatas[index - 4].imageUrl,
        name: _listDatas[index - 4].name,
        groupTitle: _showLetter ? _listDatas[index - 4].indexLetter : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text(
          '通讯录',
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 25,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverChildPage(
                        title: '添加朋友',
                      )));
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _headerData.length + _listDatas.length,
              itemBuilder: _itemForRow,
            ),
          ),
          IndexBar(
            indexBarCallBack: (String str) {
              print('收到$str == ${_groupOffsetMap[str]}');
              bool hasValue = _groupOffsetMap[str] != null ? true : false;
              if (hasValue) {
                _scrollController.animateTo(_groupOffsetMap[str],
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
//              _scrollController.jumpTo(2);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('friendspage  dispose');
    super.dispose();
  }
}

class _FriendCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  const _FriendCell(
      {Key key, this.imageUrl, this.name, this.groupTitle, this.imageAssets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            height: groupTitle != null ? 30 : 0,
            color: WeChatThemeColor,
            child: groupTitle != null
                ? Text(
                    groupTitle,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : AssetImage(imageAssets),
                  ),
                ),
              ),
              Container(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: 50,
            ),
            color: WeChatThemeColor,
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
