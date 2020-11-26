import 'package:facebook_clone_flutter_app/models/post_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PostReactions extends StatefulWidget {
  final PostModel post;
  final VoidCallback onClicked;

  const PostReactions({Key key, this.post, this.onClicked}) : super(key: key);

  @override
  _PostReactionsState createState() => _PostReactionsState();
}

class _PostReactionsState extends State<PostReactions> {
  List<String> _list = [
    "assets/icons/reactions/like.svg",
    "assets/icons/reactions/love.svg",
    "assets/icons/reactions/care.svg",
    "assets/icons/reactions/haha.svg",
    "assets/icons/reactions/wow.svg",
    "assets/icons/reactions/sad.svg",
    "assets/icons/reactions/angry.svg"
  ];
  List<String> _reactions = [
    "assets/icons/reactions/like.svg",
  ];
  List<bool> _check = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  TextEditingController textControllerReactNb = new TextEditingController();
  TextEditingController textControllerComNb = new TextEditingController();
  TextEditingController textControllerShrNb = new TextEditingController();

  int nbReactions = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onClicked != null) widget.onClicked();
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(4.0),
                title: Text(
                  'Reactions',
                  style: MyTextStyles.title.apply(color: MyColors.facebookBlue),
                  textAlign: TextAlign.center,
                ),
                content: StatefulBuilder(builder: (context, dialogSetState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              'Hold and drag to sort reacts',
                              style: TextStyle(color: MyColors.accent),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              'Reacts max selection is ',
                              style: TextStyle(color: MyColors.accent),
                            ),
                            Text(
                              '3',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 2.0)
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: ReorderableListView(
                            scrollDirection: Axis.horizontal,
                            onReorder: (int start, int current) {
                              dialogSetState(() {
                                _updateItems(start, current);
                                _updateReactions();
                              });
                            },
                            children: _list
                                .map(
                                  (item) => InkWell(
                                    key: Key(
                                        "${item.split('/').last.split('.').first}"),
                                    onTap: () {
                                      if (!_check[_list.indexOf(item)] ||
                                          nbReactions > 1) {
                                        if ((nbReactions < 3 ||
                                            _check[_list.indexOf(item)])) {
                                          dialogSetState(() {
                                            _check[_list.indexOf(item)] =
                                                !_check[_list.indexOf(item)];
                                            if (_check[_list.indexOf(item)])
                                              nbReactions++;
                                            else
                                              nbReactions--;
                                            _updateReactions();
                                          });
                                        }
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                          ),
                                          child: _check[_list.indexOf(item)]
                                              ? SvgPicture.asset('$item',
                                                  height: 40)
                                              : Opacity(
                                                  opacity: 0.6,
                                                  child: SvgPicture.asset(
                                                      '$item',
                                                      height: 40),
                                                ),
                                        ),
                                        _check[_list.indexOf(item)]
                                            ? Container(
                                                height: 2.0,
                                                width: 40.0,
                                                color: MyColors.facebookBlue,
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Reactions count',
                        style: MyTextStyles.title
                            .apply(color: MyColors.facebookBlue),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: MyColors.greyLight,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Center(
                            child: TextField(
                              controller: textControllerReactNb,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: MyTextStyles.fbText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.post.reactionsCount.toString(),
                                hintStyle: TextStyle(color: Colors.grey),
                                suffix: Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 10.0,
                                    ),
                                    onTap: () => textControllerReactNb.clear(),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                dialogSetState(() {
                                  widget.post.reactionsCount = int.parse((val));
                                });
                                rebuilde();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Comments count',
                        style: MyTextStyles.title
                            .apply(color: MyColors.facebookBlue),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: MyColors.greyLight,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Center(
                            child: TextField(
                              controller: textControllerComNb,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: MyTextStyles.fbText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.post.commentsCount.toString(),
                                hintStyle: TextStyle(color: Colors.grey),
                                suffix: Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 10.0,
                                    ),
                                    onTap: () => textControllerComNb.clear(),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                dialogSetState(() {
                                  widget.post.commentsCount = int.parse((val));
                                });
                                rebuilde();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Share count',
                        style: MyTextStyles.title
                            .apply(color: MyColors.facebookBlue),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: MyColors.greyLight,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Center(
                            child: TextField(
                              controller: textControllerShrNb,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: MyTextStyles.fbText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.post.shareCount.toString(),
                                hintStyle: TextStyle(color: Colors.grey),
                                suffix: Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 10.0,
                                    ),
                                    onTap: () => textControllerShrNb.clear(),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                dialogSetState(() {
                                  widget.post.shareCount = int.parse((val));
                                });
                                rebuilde();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                actions: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Ok'),
                  ),
                ],
              );
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.post.reactionsCount == 0
              ? SizedBox(
                  height: 10.0,
                )
              : Row(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: _reactions.map((item) {
                          return Container(
                            margin: EdgeInsets.only(
                                right:
                                    _reactions.indexOf(item).toDouble() * 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    color: Colors.white, width: 2.0)),
                            child: SvgPicture.asset('$item', height: 18),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                          .format(widget.post.reactionsCount)
                          .toString(),
                      style:
                          MyTextStyles.fbText.apply(color: MyColors.greyDark),
                    ),
                  ],
                ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  widget.post.commentsCount == 0
                      ? SizedBox()
                      : Text(
                          NumberFormat.compactCurrency(
                                      decimalDigits: 0, symbol: '')
                                  .format(widget.post.commentsCount)
                                  .toString() +
                              (widget.post.commentsCount == 1
                                  ? ' comment'
                                  : ' comments'),
                          style: MyTextStyles.fbText
                              .apply(color: MyColors.greyDark),
                        ),
                  widget.post.shareCount == 0
                      ? SizedBox()
                      : Text(
                          (widget.post.commentsCount == 0 ? '' : ' • ') +
                              NumberFormat.compactCurrency(
                                      decimalDigits: 0, symbol: '')
                                  .format(widget.post.shareCount)
                                  .toString() +
                              (widget.post.shareCount == 1
                                  ? ' share'
                                  : ' shares'),
                          style: MyTextStyles.fbText
                              .apply(color: MyColors.greyDark),
                        ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _list.removeAt(oldIndex);
      _list.insert(newIndex, item);
      final checkitem = _check.removeAt(oldIndex);
      _check.insert(newIndex, checkitem);
    });
  }

  void _updateReactions() {
    setState(() {
      _reactions.clear();
      for (int i = _list.length - 1; i >= 0; i--) {
        if (_check[i]) _reactions.add(_list[i]);
      }
    });
  }

  void rebuilde() {
    setState(() {});
  }
}
