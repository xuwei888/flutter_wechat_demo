import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/search_page.dart';

import '../../const.dart';
import 'chat_page.dart';

class SearchCell extends StatelessWidget {
  final List<Chat> datas;
  const SearchCell({this.datas});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SearchPage(
            datas: datas,
          );
        }));
      },
      child: Container(
        height: 44,
        color: WeChatThemeColor,
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 5,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('images/放大镜b.png'),
                  width: 15,
                  color: Colors.grey,
                ),
                Text(
                  '  搜索',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChange;
  const SearchBar({this.onChange});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _showClear = false;
  void _onChange(String text) {
    widget.onChange(text);
    if (text.length > 0) {
      _showClear = true;
    } else {
      _showClear = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('_SearchBarState--build');
    return Container(
      color: WeChatThemeColor,
      height: 84,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            height: 44,
//            color: Colors.red,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: ScreenWith(context) - 5 - 40,
                  height: 34,
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/放大镜b.png'),
                        width: 20,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: _onChange,
                          controller: _textEditingController,
                          autofocus: true,
                          cursorColor: Colors.green,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              bottom: 10,
                            ),
                            hintText: '搜索',
                          ),
                        ),
                      ),
                      _showClear
                          ? GestureDetector(
                              onTap: () {
                                _textEditingController.clear();
                                _onChange('');
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 20,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '  取消',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
