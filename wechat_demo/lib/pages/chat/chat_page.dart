import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wechat_demo/pages/chat/search_bar.dart';

import '../../const.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  Widget _buildPopupMenuItem(String imAsset, String title) {
    return Row(
      children: <Widget>[
        Image(
          image: AssetImage(imAsset),
          width: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  List<Chat> _datas = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDatas()
        .then((List<Chat> value) {
          print('数据有了');

          setState(() {
            _datas = value;
          });
        })
        .catchError((e) {
          print('数据$e');
        })
        .timeout(Duration(seconds: 1))
        .catchError((timeout) {
          print('时间$timeout');
        })
        .whenComplete(() {
          print('数据完成了');
        });
  }

  Future<List<Chat>> getDatas() async {
//    print('getDatas');
    final response =
        await http.get('http://rap2api.taobao.org/app/mock/268424/chat/list');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List list = responseBody['chat_list'];

//      print('list=${list}');
      List<Chat> chatList = list.map<Chat>((item) {
//        print('item=${item}');
        return Chat.fromMap(item);
      }).toList();
//      print('list=${list}');

      print('getDatas');

      return chatList;
    } else {
      print('Exception');
      throw Exception('aastatusCode:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('bulid=======bulid');
    return Scaffold(
      appBar: AppBar(
//        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: WeChatThemeColor,
        title: Text(
          '微信',
//          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 10,
            ),
            child: PopupMenuButton(
//              color: Color.fromRGBO(1, 1, 1, 0.65),
              offset: Offset(0, 80),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4))),
              onSelected: (int value) {
                print(value);
              },
              child: Image(
                image: AssetImage('images/圆加.png'),
                width: 25,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<int>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/发起群聊.png', '发起群聊'),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/添加朋友.png', '添加朋友'),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/扫一扫1.png', '扫一扫'),
                    value: 3,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/收付款.png', '收付款'),
                    value: 4,
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: _datas.length == 0
            ? Center(
                child: Text('Loading...'),
              )
            : ListView.builder(
                itemCount: _datas.length + 1,
                itemBuilder: _buildCellForRow,
              ),
      ),
    );
  }

  Widget _buildCellForRow(BuildContext context, int index) {
    if (index == 0) {
      return SearchCell(
        datas: _datas,
      );
    }
    index--;
    return ListTile(
      title: Text(_datas[index].name),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        height: 20,
        child: Text(
          _datas[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(
              image: NetworkImage(
            _datas[index].imageUrl,
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('轻轻的我走了。。。。');
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/*
    ListView(
    children: snapshot.data.map<Widget>((Chat item) {
    return ListTile(
    title: Text(item.name),
    subtitle: Container(
    alignment: Alignment.bottomCenter,
    height: 20,
    child: Text(
    item.message,
    overflow: TextOverflow.ellipsis,
    ),
    ),
    leading: Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
    image: NetworkImage(
    item.imageUrl,
    )),
    ),
    ),
    );
    }).toList(),
    )
 */

/*
FutureBuilder(
          future: getDatas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('loading...'),
              );
            }
//            print('data=${snapshot.data}');
            return ListView(
              children: snapshot.data.map<Widget>((Chat item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Container(
                    alignment: Alignment.bottomCenter,
                    height: 20,
                    child: Text(
                      item.message,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                          image: NetworkImage(
                        item.imageUrl,
                      )),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        )
        */
class Chat {
  final name;
  final imageUrl;
  final message;

  const Chat({this.name, this.imageUrl, this.message});

  factory Chat.fromMap(Map map) {
    return Chat(
      name: map['name'],
      imageUrl: map['imageUrl'],
      message: map['message'],
    );
  }
}
