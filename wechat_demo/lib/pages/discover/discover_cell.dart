import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_child_page.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;

  DiscoverCell({this.title, this.subTitle, this.imageName, this.subImageName});

  @override
  State<StatefulWidget> createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
                  title: widget.title,
                )));
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Container(
        color: _currentColor,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.title),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  widget.subTitle != null ? Text(widget.subTitle) : Text(''),
                  widget.subImageName != null
                      ? Image(
                          image: AssetImage(widget.subImageName),
                          width: 10,
                        )
                      : Container(),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
