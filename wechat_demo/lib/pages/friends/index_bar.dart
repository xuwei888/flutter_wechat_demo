import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';

class IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;

  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

int getIndex(BuildContext context, Offset globalPosition) {
  RenderBox box = context.findRenderObject();
  double y = box.globalToLocal(globalPosition).dy;
  var itemH = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  int index = (y ~/ itemH).clamp(0, INDEX_WORDS.length - 1);

  return index;
}

class _IndexBarState extends State<IndexBar> {
  Color _bcColor = Color.fromRGBO(1, 1, 1, 0);
  Color _textColor = Colors.black;
  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(
          color: _textColor,
          fontSize: 12,
        ),
      )));
    }
    return Positioned(
      right: 0,
      top: ScreenHeight(context) / 8,
      height: ScreenHeight(context) / 2,
      width: 120,
      child: Row(
        children: <Widget>[
          Container(
//            color: Colors.red,
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child: _indicatorHidden
                ? SizedBox()
                : Stack(
                    alignment: Alignment(-0.2, 0),
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/气泡.png'),
                        width: 60,
                      ),
                      Text(
                        _indicatorText,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
          GestureDetector(
            child: Container(
              width: 20,
              child: Column(
                children: words,
              ),
              color: _bcColor,
            ),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = getIndex(context, details.globalPosition);
              _indicatorText = INDEX_WORDS[index];
              widget.indexBarCallBack(_indicatorText);
              setState(() {
                _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
              });
            },
            onVerticalDragDown: (DragDownDetails details) {
              int index = getIndex(context, details.globalPosition);
              _indicatorText = INDEX_WORDS[index];
              widget.indexBarCallBack(_indicatorText);
              _indicatorHidden = false;
              setState(() {
                _bcColor = Color.fromRGBO(1, 1, 1, 0.5);
                _textColor = Colors.white;
                _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                _indicatorHidden = true;
                _bcColor = Color.fromRGBO(1, 1, 1, 0);
                _textColor = Colors.black;
              });
            },
          ),
        ],
      ),
    );
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
