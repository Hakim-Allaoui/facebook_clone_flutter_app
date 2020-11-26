import 'package:facebook_clone_flutter_app/models/reply_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/widgets/custom_editable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReplyBottomRow extends StatefulWidget {
  final Function(bool) react;
  final VoidCallback addReply;
  final ReplyModel reply;

  const ReplyBottomRow({Key key, this.react, this.addReply, this.reply})
      : super(key: key);

  @override
  _ReplyBottomRowState createState() => _ReplyBottomRowState();
}

class _ReplyBottomRowState extends State<ReplyBottomRow> {
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

  void showReactsRow() {
    showDialog(
      context: context,
      child: new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        titlePadding: EdgeInsets.all(0),
        title: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            padding: EdgeInsets.all(4.0),
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
                children: _list
                    .sublist(2, _list.length)
                    .map(
                      (item) => InkWell(
                    key: Key("${item.split('/').last.split('.').first}"),
                    onTap: () {
                      setState(() {
                        if(selectedIndex == _list.indexOf(item)){
                          widget.react(false);
                          selectedIndex = 0;
                        }else{
                          if(selectedIndex == 0) widget.react(true);
                          selectedIndex = _list.indexOf(item);
                        }
                        rebuilde();
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _list.indexOf(item) == selectedIndex
                              ? 4.0
                              : 0.0,
                          vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: _list.indexOf(item) == 0 ||
                          _list.indexOf(item) == 1
                          ? Hero(
                        tag:
                        "${item.split('/').last.split('.').first}",
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          child:
                          SvgPicture.asset('$item', height: 25),
                        ),
                      )
                          : _list.indexOf(item) == selectedIndex
                          ? Hero(
                        tag:
                        "${item.split('/').last.split('.').first}",
                        child:
                        SvgPicture.asset('$item', height: 35),
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
    return Positioned(
      bottom: 0.0,
      left: 10.0,
      child: Row(
        children: <Widget>[
          CustomEditableText(
            title: 'Elapsed time',
            text: widget.reply.elapsedTime,
            textStyle:
            MyTextStyles.fbSubTitleBold.apply(color: MyColors.greyDark),
          ),
          SizedBox(
            width: 10.0,
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.react(selectedIndex == 0 ? true : false);
                selectedIndex != 0 ? selectedIndex = 0 : selectedIndex = 1;
              });
//              if(selectedIndex == 0)
            },
            onLongPress: showReactsRow,
            child: Text(
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
                  .apply(color: _colors[selectedIndex]),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          InkWell(
              onTap: widget.addReply,
              child: Text(
                'Reply',
                style: MyTextStyles.fbSubTitleBold.apply(color: MyColors.greyDark),
              )),
        ],
      ),
    );
  }

  void rebuilde() {
    setState(() {});
  }
}
