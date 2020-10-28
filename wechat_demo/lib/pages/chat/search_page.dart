import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/search_bar.dart';

import 'chat_page.dart';

class SearchPage extends StatefulWidget {
  final List<Chat> datas;
  const SearchPage({this.datas});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextStyle _normalStyle = TextStyle(fontSize: 16, color: Colors.black);
  TextStyle _highlightStyle = TextStyle(fontSize: 16, color: Colors.green);

  List<Chat> _models = [];
  String _searchStr = '';
  void _searchData(String text) {
    List<Chat> lastModels = [];
    lastModels.addAll(widget.datas);
    if (text.length > 0) {
      if (_searchStr.length > 0) {
        if (text.contains(_searchStr)) {
          lastModels.clear();
          lastModels.addAll(_models);
        }
      }
      print(lastModels.length);
      print(_models.length);
      _models.clear();
      for (int i = 0; i < lastModels.length; i++) {
        String name = lastModels[i].name;
        if (name.contains(text)) {
          _models.add(lastModels[i]);
        }
      }
    } else {
      _models.clear();
    }
    _searchStr = text;
    setState(() {});
  }

  Widget _title(String name) {
    List<TextSpan> spans = [];
    List<String> strs = name.split(_searchStr);
    int i;
    for (i = 0; i < strs.length - 1; i++) {
      spans.add(TextSpan(text: strs[i], style: _normalStyle));
      spans.add(TextSpan(text: _searchStr, style: _highlightStyle));
    }
    spans.add(TextSpan(text: strs[i], style: _normalStyle));
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildCellForRow(BuildContext context, int index) {
    return ListTile(
      title: _title(_models[index].name),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        height: 20,
        child: Text(
          _models[index].message,
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
            _models[index].imageUrl,
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(onChange: (String text) {
            print(text);
            _searchData(text);
          }),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  itemCount: _models.length, itemBuilder: _buildCellForRow),
            ),
          ),
        ],
      ),
    );
  }
}
