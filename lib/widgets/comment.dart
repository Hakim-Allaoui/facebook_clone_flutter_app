import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/models/comment_model.dart';
import 'package:facebook_clone_flutter_app/models/reply_model.dart';
import 'package:facebook_clone_flutter_app/models/user_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/widgets/comment_bottom_row.dart';
import 'package:facebook_clone_flutter_app/widgets/comment_reactions.dart';
import 'package:facebook_clone_flutter_app/widgets/custom_editable_text.dart';
import 'package:facebook_clone_flutter_app/widgets/profile_pic.dart';
import 'package:facebook_clone_flutter_app/widgets/reply.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  final VoidCallback showInter;

  const CommentWidget({Key key, this.comment, this.showInter}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ProfilePic(
          user: widget.comment.user,
          onClicked: (val) {
            if(widget.showInter != null) widget.showInter();
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: MyColors.greyLight,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 205.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomEditableText(
                                  title: 'User Name',
                                  text: widget.comment.user.name,
                                  verified: widget.comment.user.verified,
                                  textStyle: MyTextStyles.fbTitleBold,
                                  onSubmited: (v) {
                                    if(widget.showInter != null) widget.showInter();
                                  },
                                ),
                              ],
                            ),
                            CustomEditableText(
                              title: 'Comment text',
                              text: widget.comment.text,
                              multiline: true,
                              onSubmited: (v) {
                                if(widget.showInter != null) widget.showInter();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    CommentBottomRow(
                      comment: widget.comment,
                      addReply: () async{
                        addReply().then((reply) {
                          if(reply != null) widget.comment.replys.add(reply);
                          rebuilde();
                        });
                      },
                      react: (bool reacted) {
                        setState(() {
                          if (widget.comment.reactionsCount == 0) {
                            widget.comment.reactionsCount = 1;
                          } else {
                            reacted
                                ? widget.comment.reactionsCount++
                                : widget.comment.reactionsCount--;
                          }
                        });
                      },
                    ),
                    widget.comment.reactionsCount != 0 ?
                    CommentReactions(
                      comment: widget.comment,
                    )
                    : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: widget.comment.replys == null ||
                          widget.comment.replys.length < 0
                      ? 0.0
                      : 10.0,
                ),
                widget.comment.replys == null ||
                        widget.comment.replys.length < 0
                    ? SizedBox()
                    : Column(
                        children: widget.comment.replys
                            .map(
                              (item) => ReplyWidget(
                                reply: item,
                              ),
                            )
                            .toList()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<ReplyModel> addReply() async {
    ReplyModel reply = new ReplyModel(
        user: new UserModel(
          name: 'User Name',),
        text: 'Click here to edit reply ✏.',
        elapsedTime: '15 m',
        reactionsCount: 0,
        selectedReacts: [
          true,
          false,
          false,
          false,
          false,
          false,
          false
        ]);
    Uint8List userImage;
    bool verified = false;

    TextEditingController textControllerUserName = new TextEditingController();
    TextEditingController textControllerReply = new TextEditingController();
    TextEditingController textControllerElapsedTime = new TextEditingController();
    TextEditingController textControllerReactsCount = new TextEditingController();

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Add new reply",
            style: MyTextStyles.title.apply(color: MyColors.facebookBlue),
            textAlign: TextAlign.center,
          ),
          scrollable: true,
          contentPadding: EdgeInsets.all(8.0),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: MyColors.greyDark,
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: MyColors.facebookBlue,
                      ),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            //ads.showInter();
                            reply = new ReplyModel(
                                user: new UserModel(
                                    name: textControllerUserName.text != ''
                                        ? textControllerUserName.text
                                        : 'User Name',
                                    photo: userImage,
                                    otherName: 'Other Name',
                                    bio: 'Bio Text 💭',
                                    verified: verified
                                ),
                                text: textControllerReply.text != ''
                                    ? textControllerReply.text
                                    : 'Click here to edit reply ✏.',
                                elapsedTime: textControllerElapsedTime.text != ''
                                    ? textControllerElapsedTime.text
                                    : '5 m',
                                reactionsCount: int.parse(
                                    textControllerReactsCount.text != ''
                                        ? textControllerReactsCount.text
                                        : '0'),
                                selectedReacts: [
                                  true,
                                  false,
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ]);
                            Navigator.pop(context, reply);
                          }),
                    ),
                  ),
                ],
              ),
            )
          ],
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                            child: Text(
                              'User pic',
                              style: TextStyle(color: MyColors.accent),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: MyColors.greyLight,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: ProfilePic(
                                user: reply.user,
                                onClicked: (photo) {
                                  userImage = photo;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 5.0, left: 8.0, bottom: 2.0),
                              child: Text(
                                'User Name',
                                style: TextStyle(color: MyColors.accent),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: MyColors.greyLight,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: textControllerUserName,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    style: MyTextStyles.fbText,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: textControllerUserName.text,
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
                                              textControllerUserName.clear(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                            child: Text(
                              'Verified',
                              style: TextStyle(color: MyColors.accent),
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/verified_badge.svg',
                              width: 30.0,
                              color: verified ? MyColors.accent : MyColors.greyLight,
                            ),
                            onPressed: () {
                              verified = !verified;
                              setState((){});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      'Reply text',
                      style: TextStyle(color: MyColors.accent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: MyColors.greyLight,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: textControllerReply,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          style: MyTextStyles.fbText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textControllerReply.text,
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
                                onTap: () => textControllerReply.clear(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      'Elapsed time',
                      style: TextStyle(color: MyColors.accent),
                    ),
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
                          controller: textControllerElapsedTime,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: MyTextStyles.fbText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textControllerElapsedTime.text,
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
                                onTap: () => textControllerElapsedTime.clear(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      'Reacts Count',
                      style: TextStyle(color: MyColors.accent),
                    ),
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
                          controller: textControllerReactsCount,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          style: MyTextStyles.fbText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textControllerReactsCount.text,
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
                                onTap: () => textControllerReactsCount.clear(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  void rebuilde() {
    setState(() {});
  }
}
