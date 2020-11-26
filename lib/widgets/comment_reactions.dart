import 'package:facebook_clone_flutter_app/models/comment_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CommentReactions extends StatefulWidget {
  final CommentModel comment;

  const CommentReactions({Key key, this.comment}) : super(key: key);

  @override
  _CommentReactionsState createState() => _CommentReactionsState();
}

class _CommentReactionsState extends State<CommentReactions> {
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

  int iconsReactionsCount = 1;

  List<bool> selectedReactions = [];

  int reactionsCount;
  TextEditingController textControllerReactNb = new TextEditingController();

  @override
  void initState() {
    super.initState();
    reactionsCount = widget.comment.reactionsCount;
    selectedReactions = widget.comment.selectedReacts;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 2.0,
      right: 5.0,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(4.0),
                  title: Text(
                    'Reactions',
                    style:
                        MyTextStyles.title.apply(color: MyColors.facebookBlue),
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
                                        if (!widget.comment.selectedReacts[
                                                _list.indexOf(item)] ||
                                            iconsReactionsCount > 1) {
                                          if ((iconsReactionsCount < 3 ||
                                              widget.comment.selectedReacts[
                                                  _list.indexOf(item)])) {
                                            dialogSetState(() {
                                              widget.comment.selectedReacts[
                                                  _list.indexOf(item)] = !widget
                                                      .comment.selectedReacts[
                                                  _list.indexOf(item)];
                                              if (widget.comment.selectedReacts[
                                                  _list.indexOf(item)])
                                                iconsReactionsCount++;
                                              else
                                                iconsReactionsCount--;
                                            });
                                          }
                                        }
                                        _updateReactions();
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
                                            child:
                                                widget.comment.selectedReacts[
                                                        _list.indexOf(item)]
                                                    ? SvgPicture.asset('$item',
                                                        height: 40)
                                                    : Opacity(
                                                        opacity: 0.6,
                                                        child: SvgPicture.asset(
                                                            '$item',
                                                            height: 40),
                                                      ),
                                          ),
                                          widget.comment.selectedReacts[
                                                  _list.indexOf(item)]
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
                                  hintText:
                                      widget.comment.reactionsCount.toString(),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffix: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colors.black,
                                    ),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 10.0,
                                      ),
                                      onTap: () =>
                                          textControllerReactNb.clear(),
                                    ),
                                  ),
                                ),
                                onChanged: (count) {
                                  widget.comment.reactionsCount =
                                      int.parse(count);
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
        child: widget.comment.reactionsCount == 0
            ? SizedBox()
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.5, 1.0),
                        blurRadius: 1.0)
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                            child: SvgPicture.asset('$item', height: 15),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Text(
                        NumberFormat.compactCurrency(
                                decimalDigits: 0, symbol: '')
                            .format(widget.comment.reactionsCount)
                            .toString(),
                        style:
                            MyTextStyles.fbText.apply(color: MyColors.greyDark),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = _list.removeAt(oldIndex);
    _list.insert(newIndex, item);
    final checkitem = widget.comment.selectedReacts.removeAt(oldIndex);
    widget.comment.selectedReacts.insert(newIndex, checkitem);
  }

  void _updateReactions() {
    setState(() {
      _reactions.clear();
      for (int i = _list.length - 1; i >= 0; i--) {
        if (widget.comment.selectedReacts[i]) _reactions.add(_list[i]);
      }
    });
  }

  void rebuilde() {
    setState(() {});
  }
}
