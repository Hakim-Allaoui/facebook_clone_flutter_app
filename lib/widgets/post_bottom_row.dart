import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostBottomRow extends StatefulWidget {
  final VoidCallback addComment;
  final VoidCallback onClicked;

  const PostBottomRow({Key key, this.addComment, this.onClicked}) : super(key: key);
  @override
  _PostBottomRowState createState() => _PostBottomRowState();
}

class _PostBottomRowState extends State<PostBottomRow> {
  List<String> _list = [
    "assets/icons/like_strock.svg",
    "assets/icons/like_fill.svg",
    "assets/icons/reactions/love.svg",
    "assets/icons/reactions/care.svg",
    "assets/icons/reactions/haha.svg",
    "assets/icons/reactions/wow.svg",
    "assets/icons/reactions/sad.svg",
    "assets/icons/reactions/angry.svg",
  ];

  List<Color> _colors = [
    MyColors.greyDark,
    Color(0XFF5C94FF),
    Color(0XFFE4455C),
    Color(0XFFFFC33A),
    Color(0XFFFFC33A),
    Color(0XFFFFC33A),
    Color(0XFFFFC33A),
    Color(0XFFDC751E),
  ];

  int selectedIndex = 0;

  void showReactsRow(){
    showDialog(
      context: context,
      child: new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        titlePadding: EdgeInsets.all(0),
        title: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 2.0),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _list.sublist(2,_list.length)
                        .map(
                          (item) => InkWell(
                        key:
                        Key("${item.split('/').last.split('.').first}"),
                        onTap: () {
                          setState(() {
                            selectedIndex = _list.indexOf(item);
                            rebuilde();
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal:
                              _list.indexOf(item) == selectedIndex
                                  ? 4.0
                                  : 0.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: _list.indexOf(item) == 0 || _list.indexOf(item) == 1
                              ? Hero(
                            tag:
                            "${item.split('/').last.split('.').first}",
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              child: SvgPicture.asset('$item',
                                  height: 25),
                            ),
                          )
                              : _list.indexOf(item) == selectedIndex
                              ? Hero(
                            tag:
                            "${item.split('/').last.split('.').first}",
                            child: SvgPicture.asset('$item',
                                height: 35),
                          )
                              : Opacity(
                            opacity: 0.8,
                            child: Hero(
                              tag:
                              "${item.split('/').last.split('.').first}",
                              child: SvgPicture.asset('$item',
                                  height: 30),
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              selectedIndex == 0 ? selectedIndex = 1 : selectedIndex = 0;
            });
          },
          onLongPress: () {
            showReactsRow();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "${_list[selectedIndex].split('/').last.split('.').first}",
                  child: SvgPicture.asset(
                    _list[selectedIndex],
                    height: 20.0,
                  ),
                ),
              ),
              Text(
                _list[selectedIndex]
                    .split('/')
                    .last
                    .split('.')
                    .first
                    .substring(0, 1)
                    .toUpperCase() +
                    _list[selectedIndex]
                        .split('/')
                        .last
                        .split('.')
                        .first
                        .substring(
                        1,
                        _list[selectedIndex]
                            .split('/')
                            .last
                            .split('.')
                            .first
                            .length)
                        .split("_")
                        .first,
                style: MyTextStyles.fbSubTitleBold
                    .apply(color: _colors[selectedIndex], fontSizeFactor: 0.9),
              )
            ],
          ),
        ),
        InkWell(
          onTap: widget.addComment,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/icons/comment.svg',
                  height: 20.0,
                  color: MyColors.greyDark,
                ),
              ),
              Text('comment', style: MyTextStyles.fbSubTitleBold.apply(color: MyColors.greyDark, fontSizeFactor: 0.9),)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/share.svg',
                height: 20.0,
                color: MyColors.greyDark,
              ),
            ),
            Text('share', style: MyTextStyles.fbSubTitleBold.apply(color: MyColors.greyDark, fontSizeFactor: 0.9),)
          ],
        ),
      ],
    );
  }

  void rebuilde() {
    setState(() {});
  }
}